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

class Login extends AuthEvent {
  final String phoneNumber;
  final String password;
  const Login(this.phoneNumber, this.password);

  @override
  List<Object> get props => [phoneNumber, password];
}

class UpdateUserFirebaseData extends AuthEvent {}

class SendOtp extends AuthEvent {
  final String phoneNumber;
  const SendOtp(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtp extends AuthEvent {
  final String otpToken;
  final String phone;
  final String otpCode;
  const VerifyOtp(this.otpToken, this.phone, this.otpCode);

  @override
  List<Object> get props => [otpToken, phone, otpCode];
}

class ChangePassword extends AuthEvent {
  final String password;
  final String confirmPassword;
  const ChangePassword(this.password, this.confirmPassword);

  @override
  List<Object> get props => [password, confirmPassword];
}
