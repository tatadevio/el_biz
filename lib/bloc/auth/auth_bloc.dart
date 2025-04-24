import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/data/repo/auth_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/auth/otp_screen.dart';
import 'package:el_biz/view/screen/auth/password_changed_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../../view/screen/auth/change_password_screen.dart';

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
        // sharedPreferences.setString(AppConstants.token, res.body['token']);
        // Get.offAll(() => DashboardScreen());
        // Get.offAll(() => PasswordScreen(phoneNumber: event.phone));
        Get.to(() => ChangePasswordScreen());
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
      }
      // else {

      // }
      showCustomSnackBar(res.body['message']);
    });

    on<Login>((event, emit) async {
      emit(state.copywith(isLoading: true));
      final res = await authRepo.login(event.phoneNumber, event.password);
      print(res.body);
      emit(state.copywith(isLoading: false));
      if (res.body['status_code'] == 200) {
        await _saveToken(res.body['data']['token']);
        add(CheckLoginStatus());
        Get.offAll(() => DashboardScreen());
      }
      showCustomSnackBar(res.body['message']);
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
        add(UpdateUserFirebaseData());
        emit(state.copywith(isLoading: false));
      } catch (e) {
        showCustomSnackBar(e.toString());
        // emit(AuthError(e.toString()));
        emit(state.copywith(isLoading: false));
      }
    });

    on<UpdateUserFirebaseData>(_updateUserDataOnFirebase);
  }

  void _updateUserDataOnFirebase(
      UpdateUserFirebaseData event, Emitter<AuthState> state) async {
    String userId = 'userId';
    if (_auth.currentUser != null) {
      userId = FirebaseAuth.instance.currentUser!.uid;
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String fcmToken = '@';

    try {
      String? token = await messaging.getToken();
      if (token != null) {
        print('FCM Token: $token');
        fcmToken = token;
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }

    Map<String, dynamic> userData = {
      "userId": userId,
      "fcmToken": fcmToken,
      "time": DateTime.now(),
    };
    FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
  }

  Future<void> _saveToken(String token) async {
    // print('this is saving token: $token');
    await authRepo.saveToken(token);
    final sharedPreferences = await SharedPreferences.getInstance();
    String lang =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "ru";
    print('going to update the api client header : ${lang} and ${token}');
    ApiClient(
            appBaseUrl: AppConstants.baseUrl,
            sharedPreferences: await SharedPreferences.getInstance())
        .updateHeader(token, lang);
  }
}
