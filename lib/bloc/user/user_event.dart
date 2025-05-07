part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserEvent {
  const GetUserInfo();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const UpdateUserData(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber});

  @override
  List<Object> get props => [firstName, lastName, email, phoneNumber];
}

class SwitchSelectedAccount extends UserEvent {
  final UserData profile;
  final CompanyItem companyItem;
  final bool isUser;

  const SwitchSelectedAccount({required this.profile, required this.companyItem, required this.isUser});

  @override
  List<Object> get props => [profile, companyItem, isUser];
}

class GetSelectedAccount extends UserEvent {
  
}
