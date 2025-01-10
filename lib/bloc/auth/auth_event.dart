part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginStatus extends AuthEvent {}

class UpdateCountryCode extends AuthEvent {
  final String code;
  const UpdateCountryCode(this.code);

  @override
  List<Object> get props => [code];
}

class PhoneAuthentication extends AuthEvent {
  final String phoneNumber;
  const PhoneAuthentication(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOTP extends AuthEvent {
  final String verificationId;
  final String otp;
  const VerifyOTP(this.verificationId, this.otp);

  @override
  List<Object> get props => [verificationId, otp];
}

class UpdateUserFirebaseData extends AuthEvent {}
