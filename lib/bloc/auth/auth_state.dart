part of 'auth_bloc.dart';

// abstract class AuthState1{}

// class LoadingSucessState extends AuthState1{}

// class LoadingErrorState extends AuthState1{
//   final String error;
//   LoadingErrorState(this.error);
// }

class AuthState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final String countryCode;
  const AuthState(
      {this.isLoading = false,
      this.isLoggedIn = false,
      this.countryCode = '+996'});

  AuthState copywith({bool? isLoading, bool? isLoggedIn, String? countryCode}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object> get props => [isLoading, isLoggedIn, countryCode];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid;
  const AuthSuccess(this.uid);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
