part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserInfoModel? userInfo;
  const UserState({this.userInfo});

  UserState copyWith({UserInfoModel? userInfo}) {
    return UserState(userInfo: userInfo ?? this.userInfo);
  }

  @override
  List<Object> get props => [userInfo as UserInfoModel];
}

final class UserInitial extends UserState {}
