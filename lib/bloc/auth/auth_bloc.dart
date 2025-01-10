import 'package:el_biz/data/repo/auth_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/auth/otp_screen.dart';
import 'package:equatable/equatable.dart';
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
            emit(state.copywith(isLoading: false));
            Get.to(() =>
                OtpScreen(phone: event.phoneNumber, type: verificationId));
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
        // emit(AuthVerified());
        emit(state.copywith(isLoading: false));
      } catch (e) {
        showCustomSnackBar(e.toString());
        // emit(AuthError(e.toString()));
        emit(state.copywith(isLoading: false));
      }
    });
  }
}

//   Future<ResponseModel> phoneAuthentication(String phoneNumber, String type) async {
//     ResponseModel responseModel;
//     responseModel = ResponseModel(false, "Failure");
//     _phoneNumber = phoneNumber;
//     _isLoading = true;
//     print('this is phone number : $_phoneNumber');
//     update();
//     // try {
//     //   await _auth.verifyPhoneNumber(
//     //     timeout: const Duration(seconds: 30),
//     //     phoneNumber: phoneNumber,
//     //     verificationCompleted: (credential) async {
//     //       print("i am verification");
//     //       // await _auth.signInWithCredential(credential);
//     //     },
//     //     codeSent: (verificationId, resendToken) {
//     //       this.verificationId.value = verificationId;
//     //       _isLoading = false;
//     //       update();
//     //       print("i am code sent");
//     //       responseModel = ResponseModel(true, "Success");
//     //       Get.to(() => OtpScreen(
//     //             phone: _phoneNumber,
//     //             type: type,
//     //           ));
//     //     },
//     //     codeAutoRetrievalTimeout: (verificationId) {
//     //       this.verificationId.value = verificationId;
//     //       print("code retrival timeout");
//     //       responseModel = ResponseModel(false, "Failure");
//     //     },
//     //     verificationFailed: (FirebaseAuthException e) {
//     //       print(e.code);
//     //       print(e.message);
//     //       print(e);
//     //       _isLoading = false;
//     //       update();
//     //       responseModel = ResponseModel(false, "Failure");
//     //       if (e.code == 'invalid-phone-number') {
//     //         showShortToast("Указанный номер телефона недействителен");
//     //       } else if (e.code == '') {
//     //         showShortToast(e.code + e.toString());
//     //         //showShortToast("Something went wrong");
//     //       } else {
//     //         showShortToast(e.code + e.toString());
//     //         //showShortToast("Something went wrong");
//     //       }
//     //     },
//     //   );
//     // } catch (e) {
//     //   print(e);
//     // }
//     return responseModel;
//   }

//   Future<bool> verifyOtp(String otp, BuildContext context) async {
//     var credential;
//     _isOtpLoading = true;
//     update();
//     // try {
//     //   credential = await _auth.signInWithCredential(
//     //       PhoneAuthProvider.credential(
//     //           verificationId: verificationId.value, smsCode: otp));
//     //   _firebaseId = credential.user!.uid;
//     // } on FirebaseAuthException catch (e) {
//     //   credential = null;
//     //   showShortToast("This issue ${e.message}");

//     //   popUpAlert(context, e.message!, Colors.red,
//     //       firebaseError: true, code: e.code);
//     //   print(e);
//     // }
//     _isOtpLoading = false;
//     update();

//     return credential == null
//         ? false
//         : credential.user != null
//             ? true
//             : false;
//   }
