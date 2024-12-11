import 'package:el_biz/data/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc(this.authRepo) : super(const AuthState()) {
    on<CheckLoginStatus>((event, emit) {
      final loggedIn = authRepo.isLoggedIn();
      emit(state.copywith(isLoggedIn: loggedIn));
    });

    on<UpdateCountryCode>((event, emit) {
      emit(state.copywith(countryCode: event.code));
    });
  }
}
