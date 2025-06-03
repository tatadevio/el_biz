part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserEvent {
  final BuildContext context;
  const GetUserInfo({required this.context});

  @override
  List<Object> get props => [context];
}

class UpdateUserData extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final BuildContext context;

  const UpdateUserData(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber, required this.context});

  @override
  List<Object> get props => [firstName, lastName, email, phoneNumber, context];
}

class SwitchSelectedAccount extends UserEvent {
  final UserData profile;
  final CompanyItem companyItem;
  final bool isUser;

  const SwitchSelectedAccount(
      {required this.profile, required this.companyItem, required this.isUser});

  @override
  List<Object> get props => [profile, companyItem, isUser];
}

class GetSelectedAccount extends UserEvent {
  final BuildContext context;
  const GetSelectedAccount({required this.context});

  @override
  List<Object> get props => [context];
}

class ClearSelectedAccount extends UserEvent {}
