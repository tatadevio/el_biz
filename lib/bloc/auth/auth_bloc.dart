import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/data/repo/auth_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/auth/otp_screen.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseAuth
  AuthBloc(this.authRepo) : super(const AuthState()) {
    on<CheckLoginStatus>((event, emit) {
      final loggedIn = authRepo.isLoggedIn();
      emit(state.copywith(isLoggedIn: loggedIn));
    });

    // on<Login>(
    //   (event, emit) {
    //     final res = await authRepo.isLoggedIn();
    //     res.fold(

    //     );
    //   }
    // );

    on<UpdateCountryCode>((event, emit) {
      emit(state.copywith(countryCode: event.code));
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
}
