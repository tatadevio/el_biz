import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/repo/auth_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/auth/otp_screen.dart';
import 'package:el_biz/view/screen/auth/password_changed_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:el_biz/view/screen/home/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../view/screen/auth/change_password_screen.dart';
import '../../view/screen/auth/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseAuth
  AuthBloc(this.authRepo) : super(const AuthState()) {
    on<CheckLoginStatus>((event, emit) async {
      final loggedIn = await authRepo.isLoggedIn();
      print("this is loggedIn: $loggedIn");
      emit(state.copywith(isLoggedIn: loggedIn));
    });

    on<UpdateCountryCode>((event, emit) {
      emit(state.copywith(countryCode: event.code));
    });

    on<SendOtp>((event, emit) async {
      emit(state.copywith(isLoading: true));
      final res = await authRepo.sendOtp(event.phoneNumber);
      print(res.body);
      emit(state.copywith(isLoading: false));
      if (res.body['otpsend'] == true) {
        Get.to(() =>
            OtpScreen(phone: event.phoneNumber, type: res.body['otp_token']));
      } else {
        showCustomSnackBar(res.body['message']);
      }
    });

    on<VerifyOtp>((event, emit) async {
      emit(state.copywith(isLoading: true));
      final res =
          await authRepo.verifyOtp(event.otpToken, event.phone, event.otpCode);
      print(res.body);
      emit(state.copywith(isLoading: false));
      if (res.body['otp'] == true) {
        await _saveToken(res.body['token']);
        add(CheckLoginStatus());

        if (await authRepo.isLoggedIn() == true) {
          print('user if loged in');
          event.context
              .read<UserBloc>()
              .add(GetUserInfo(context: event.context));
          // sharedPreferences.setString(AppConstants.token, res.body['token']);
          // Get.offAll(() => DashboardScreen());
          // Get.offAll(() => PasswordScreen(phoneNumber: event.phone));
          Get.to(() => ChangePasswordScreen());
          // ignore: use_build_context_synchronously
          event.context
              .read<UserBloc>()
              // ignore: use_build_context_synchronously
              .add(GetSelectedAccount(context: event.context));
        }
      } else {
        showCustomSnackBar(res.body['message']);
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(state.copywith(isLoading: true));
      final res =
          await authRepo.changePassword(event.password, event.confirmPassword);
      print(res.body);

      emit(state.copywith(isLoading: false));
      if (res.body['status_code'] == 200) {
        Get.offAll(() => PasswordChangedScreen());
        // update user data
        if (res.body['status_code'] == 200) {
          add(CheckLoginStatus());
          if (await authRepo.isLoggedIn() == true) {
            // ignore: use_build_context_synchronously
            event.context
                .read<UserBloc>()
                // ignore: use_build_context_synchronously
                .add(GetUserInfo(context: event.context));

            // ignore: use_build_context_synchronously
            event.context
                .read<UserBloc>()
                // ignore: use_build_context_synchronously
                .add(GetSelectedAccount(context: event.context));
          }
        }
      }
      // else {

      // }
      showShortToast(res.body['message']);
    });

    on<Login>((event, emit) async {
      emit(state.copywith(isLoading: true));
      final res = await authRepo.login(event.phoneNumber, event.password);
      print("this is res: ${res.statusCode} and ${res.body}");
      print(res.body);
      emit(state.copywith(isLoading: false));
      print("this is res.body['status_code']: ${res.body['status_code']}");
      if (res.body['status_code'] == 200) {
        await _saveToken(res.body['data']['token']);
        add(CheckLoginStatus());
        if (await authRepo.isLoggedIn() == true) {
          // ignore: use_build_context_synchronously
          event.context
              .read<UserBloc>()
              // ignore: use_build_context_synchronously
              .add(GetUserInfo(context: event.context));

          HomeScreen().loadData(event.context);

          Get.offAll(() => DashboardScreen());
          // ignore: use_build_context_synchronously
          event.context
              .read<UserBloc>()
              // ignore: use_build_context_synchronously
              .add(GetSelectedAccount(context: event.context));
        }
      }
      showShortToast(res.body['message']);
    });

    on<PhoneAuthentication>((event, emit) async {
      emit(state.copywith(isLoading: true));

      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            // emit(AuthVerified());
            emit(state.copywith(isLoading: false));
          },
          verificationFailed: (FirebaseAuthException e) {
            // emit(AuthError(e.message ?? "Verification failed"));
            showCustomSnackBar(e.message.toString());
            emit(state.copywith(isLoading: false));
          },
          codeSent: (String verificationId, int? resendToken) {
            Get.to(() =>
                OtpScreen(phone: event.phoneNumber, type: verificationId));
            emit(state.copywith(isLoading: false));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        // emit(AuthError(e.toString()));
        showCustomSnackBar(e.toString());
        emit(state.copywith(isLoading: false));
      }
      emit(state.copywith(isLoading: false));
    });

    on<VerifyOTP>((event, emit) async {
      // emit(AuthLoading());
      emit(state.copywith(isLoading: true));
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.otp,
        );
        await _auth.signInWithCredential(credential);
        Get.offAll(() => DashboardScreen());
        // emit(AuthVerified());
        emit(state.copywith(isLoading: false));
      } catch (e) {
        showCustomSnackBar(e.toString());
        // emit(AuthError(e.toString()));
        emit(state.copywith(isLoading: false));
      }
    });

    // on<UpdateUserFirebaseData>(_updateUserDataOnFirebase);

    on<Logout>((event, emit) async {
      await authRepo.logout();

      Get.offAll(() => const LoginScreen());
    });

    on<DeleteAccount>(_onDeleteAccount);
    on<UpdateFirebaseToken>(_updateFirebaseToken);
  }

  Future<void> _updateFirebaseToken(
      UpdateFirebaseToken event, Emitter<AuthState> emit) async {
    print('this is updating firebase token: ${event.userId}');
    await authRepo.updateToken(event.userId);
  }

  // void _updateUserDataOnFirebase(
  //     UpdateUserFirebaseData event, Emitter<AuthState> state) async {
  //   String userId = event.userId;
  //   if (_auth.currentUser != null) {
  //     userId = FirebaseAuth.instance.currentUser!.uid;
  //   }

  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   String fcmToken = '@';

  //   try {
  //     String? token = await messaging.getToken();
  //     if (token != null) {
  //       print('FCM Token: $token');
  //       fcmToken = token;
  //     }
  //   } catch (e) {
  //     print('Error getting FCM token: $e');
  //   }

  //   Map<String, dynamic> userData = {
  //     "userId": userId,
  //     "fcmToken": fcmToken,
  //     "time": DateTime.now(),
  //   };
  //   FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
  //   authRepo.updateToken(userId);
  // }

  Future<void> _onDeleteAccount(
      DeleteAccount event, Emitter<AuthState> emit) async {
    emit(state.copywith(isLoading: true));

    try {
      final response = await authRepo.deleteAccount();
      if (response.statusCode == 200) {
        showShortToast(response.body['message']);
        add(Logout());
      }
    } catch (e) {}
    emit(state.copywith(isLoading: false));
  }

  Future<void> _saveToken(String token) async {
    // print('this is saving token: $token');
    print('saving token = $token');
    await authRepo.saveToken(token);
  }
}
