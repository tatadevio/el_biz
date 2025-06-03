// part of 'user_bloc.dart';

// class UserState extends Equatable {
//   final bool isLoading;
//   final UserInfoModel? userInfo;
//   final SelectedAccountModel? selectedAccountModel;
//   const UserState(
//       {required this.userInfo, this.isLoading = false, required this.selectedAccountModel});

//   UserState copyWith(
//       {bool? isLoading,
//       UserInfoModel? userInfo,
//       SelectedAccountModel? selectedAccountModel}) {
//     return UserState(
//       isLoading: isLoading ?? this.isLoading,
//       userInfo: userInfo ?? this.userInfo,
//       selectedAccountModel: selectedAccountModel ?? this.selectedAccountModel,
//     );
//   }

//   @override
//   List<Object> get props => [isLoading, userInfo, selectedAccountModel];
// }

// // final class UserInitial extends UserState {}
// final class UserInitial extends UserState {
//   UserInitial()
//       : super(
//             isLoading: false,
//             userInfo: null,
//             selectedAccountModel: SelectedAccountModel(
//               userId: 1,
//               userName: 'userName',
//               userImage: 'userImage',
//               userRole: 'userRole',
//               userEmail: '',
//               companyId: 0,
//               companyName: 'companyName',
//               isUser: false,
//               userPhone: '',
//               companyPhone: '',
//               companyEmail: '',
//             ));
// }

// class UpdateUserDataSuccess extends UserState {}

// class UpdateUserDataError extends UserState {
//   final String error;

//   const UpdateUserDataError({required this.error});
// }

part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLoading;
  final UserInfoModel? userInfo;
  final SelectedAccountModel? selectedAccountModel;

  const UserState({
    this.userInfo,
    this.isLoading = false,
    this.selectedAccountModel,
  });

  UserState copyWith({
    bool? isLoading,
    UserInfoModel? userInfo,
    SelectedAccountModel? selectedAccountModel,
    bool clearUserInfo = false,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      userInfo:
          clearUserInfo ? null : (userInfo != null ? userInfo : this.userInfo),
      selectedAccountModel: clearUserInfo
          ? null
          : (selectedAccountModel != null
              ? selectedAccountModel
              : this.selectedAccountModel),

      // isLoading: isLoading ?? this.isLoading,
      // userInfo: userInfo ?? this.userInfo,
      // selectedAccountModel: selectedAccountModel ?? this.selectedAccountModel,
    );
  }

  @override
  List<Object?> get props => [isLoading, userInfo, selectedAccountModel];
}

final class UserInitial extends UserState {
  UserInitial()
      : super(
          isLoading: false,
          userInfo: null,
          selectedAccountModel: SelectedAccountModel(
            userId: 1,
            userName: 'userName',
            userImage: 'userImage',
            userRole: 'userRole',
            userEmail: '',
            companyId: 0,
            companyName: 'companyName',
            isUser: false,
            userPhone: '',
            companyPhone: '',
            companyEmail: '',
          ),
        );
}

class UpdateUserDataSuccess extends UserState {}

class UpdateUserDataError extends UserState {
  final String error;

  const UpdateUserDataError({required this.error});
}
