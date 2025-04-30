part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLoading;
  final UserInfoModel? userInfo;
  const UserState({this.userInfo, this.isLoading = false});

  UserState copyWith({bool? isLoading, UserInfoModel? userInfo}) {
    return UserState(
        isLoading: isLoading ?? this.isLoading,
        userInfo: userInfo ?? this.userInfo);
  }

  @override
  List<Object> get props => [isLoading, userInfo!];
}

final class UserInitial extends UserState {}

class UpdateUserDataSuccess extends UserState {}

class UpdateUserDataError extends UserState {
  final String error;

  const UpdateUserDataError({required this.error});
}
