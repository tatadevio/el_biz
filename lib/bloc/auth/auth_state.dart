part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final String countryCode;
  const AuthState({this.isLoading = false, this.isLoggedIn = false, this.countryCode = '+996'});

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

// final class AuthInitial extends AuthState {}
