import 'dart:convert';

import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../data/model/response/account/selected_account_model.dart';
import '../../data/model/response/company/my_companies_model.dart';
import '../../data/model/response/userinfo_model.dart';
import '../../data/repo/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;
  UserBloc(this.userRepo) : super(UserInitial()) {
    // on<GetUserInfo>((event, emit) async {
    //   try {
    //     final res = await userRepo.getUserInfo();
    //     print('====> User Info: ${res.body}');
    //     if (res.statusCode == 200) {
    //       UserInfoModel userInfo = UserInfoModel.fromJson(res.body);
    //       emit(state.copyWith(userInfo: userInfo));
    //       // ignore: use_build_context_synchronously
    //       add(GetSelectedAccount(context: event.context));
    //     } else {
    //       showShortToast(res.body['message']);
    //     }
    //   } catch (e) {
    //     showShortToast(e.toString());
    //   }
    // });

    // on<UserEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetUserInfo>(_onGetUserInfo);
    on<UpdateUserData>(_onUpdateUserData);
    on<SwitchSelectedAccount>(_onSwichSelectedAccount);
    on<GetSelectedAccount>(_onGetSelectedAccount);
    on<ClearSelectedAccount>(_onClearSelectedAccount);
  }

  Future<void> _onGetUserInfo(
      GetUserInfo event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await userRepo.getUserInfo();
      print('====> User Info: ${res.body}');
      if (res.statusCode == 200) {
        UserInfoModel userInfo = UserInfoModel.fromJson(res.body);
        emit(state.copyWith(userInfo: userInfo));
        // ignore: use_build_context_synchronously
        if (event.isUpdateToken) {
          event.context.read<AuthBloc>().add(UpdateFirebaseToken(
                state.userInfo?.data?.id.toString() ?? "",
              ));
        }
        add(GetSelectedAccount(context: event.context));
      } else {
        showShortToast(res.body['message']);
      }
    } catch (e) {
      showShortToast(e.toString());
    }
  }

  Future<void> _onUpdateUserData(
      UpdateUserData event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await userRepo.updateUserData(
          event.firstName, event.lastName, event.email, event.phoneNumber);
      if (response.statusCode == 200) {
        emit(UpdateUserDataSuccess());

        UserData userData = UserData.fromJson(response.body['data']);
        // final userInfoData = state.userInfo?.copyWith(data: userData);
        final updatedUserInfo = state.userInfo != null
            ? state.userInfo!.copyWith(data: userData)
            : UserInfoModel(data: userData);

        emit(state.copyWith(userInfo: updatedUserInfo));
        showShortToast('profile_updated'.tr);

// start update saved user data
        final accountData = userRepo.getSelectedAccount();
        SelectedAccountModel selectedAccount =
            SelectedAccountModel.fromJson(jsonDecode(accountData));

        if (selectedAccount.isUser == true) {
          final updatedAccount = SelectedAccountModel(
            userId: userData.id!,
            userName: userData.name ?? '',
            userImage: userData.image ?? '',
            userPhone: userData.phone ?? '',
            userEmail: userData.email ?? '',
            userRole: userData.userRole,
            companyId: selectedAccount.companyId,
            companyName: selectedAccount.companyName,
            companyLogo: selectedAccount.companyLogo,
            verificationStatus: selectedAccount.verificationStatus,
            companyPhone: selectedAccount.companyPhone,
            companyEmail: selectedAccount.companyEmail,
            isUser: selectedAccount.isUser,
          );
          emit(state.copyWith(selectedAccountModel: updatedAccount));
          await userRepo.saveSelectedAccount(updatedAccount);
          add(GetSelectedAccount(context: event.context));
        }

// end update saved user data
      } else {
        showShortToast(response.body['message']);
        emit(UpdateUserDataError(error: 'error'.tr));
      }
    } catch (e) {
      showShortToast(e.toString());
      emit(UpdateUserDataError(error: e.toString()));
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onSwichSelectedAccount(
      SwitchSelectedAccount event, Emitter<UserState> emit) async {
    if (event.isUser) {
      final data = event.profile;
      SelectedAccountModel selectedAccount = SelectedAccountModel(
        userId: data.id!,
        userName: data.name ?? '',
        userImage: data.image ?? '',
        userRole: data.userRole,
        userPhone: data.phone ?? '',
        userEmail: data.email ?? '',
        companyId: 0,
        companyName: '',
        isUser: true,
        companyPhone: '',
        companyLogo: '',
        companyEmail: '',
      );
      emit(state.copyWith(selectedAccountModel: selectedAccount));
      bool isSave = await userRepo.saveSelectedAccount(selectedAccount);
      if (isSave) {
        // showShortToast('udpated'.tr);
      }
    } else {
      final data = event.companyItem;
      final selectedAccount = SelectedAccountModel(
        userId: data.owner?.id ?? 0,
        userName: data.owner?.name ?? '',
        userImage: data.owner?.image ?? '',
        userPhone: data.owner?.phone ?? '',
        userEmail: data.owner?.email ?? '',
        userRole: 'owner',
        companyId: data.id!,
        companyName: data.name ?? '',
        companyLogo: data.logo ?? '',
        verificationStatus: data.verificationStatus ?? '',
        companyPhone: data.phone ?? '',
        companyEmail: data.email ?? '',
        isUser: false,
      );
      emit(state.copyWith(selectedAccountModel: selectedAccount));
      bool isSave = await userRepo.saveSelectedAccount(selectedAccount);
      if (isSave) {
        // showShortToast('udpated'.tr);
      }
    }
  }

  Future<void> _onGetSelectedAccount(
      GetSelectedAccount event, Emitter<UserState> emit) async {
    String accountData = userRepo.getSelectedAccount();
    if (accountData == "") {
      final data = state.userInfo?.data;
      if (data != null) {
        SelectedAccountModel selectedAccount = SelectedAccountModel(
          userId: data.id!,
          userName: data.name ?? '',
          userImage: data.image ?? '',
          userRole: data.userRole,
          userPhone: data.phone ?? '',
          userEmail: data.email ?? '',
          companyId: 0,
          companyName: '',
          isUser: true,
          companyPhone: '',
          companyLogo: '',
          companyEmail: '',
        );
        emit(state.copyWith(selectedAccountModel: selectedAccount));
        // bool isSave =
        await userRepo.saveSelectedAccount(selectedAccount);
        // if (isSave) {
        //   showShortToast('udpate new profile data');
        // } else {
        //   showShortToast('updated new profile data is not save');
        // }
      } else {
        // showShortToast('data is null');
        add(GetUserInfo(context: event.context));
        if (event.context.read<AuthBloc>().state.isLoggedIn) {
          Future.delayed(Duration(seconds: 5), () async {
            // ignore: use_build_context_synchronously
            add(GetSelectedAccount(context: event.context));
          });
        }
      }
    } else {
      SelectedAccountModel selectedAccount =
          SelectedAccountModel.fromJson(jsonDecode(accountData));
      // showShortToast(selectedAccount.toJson().toString());
      // print('this is loaded data : ${selectedAccount.toJson()}');
      emit(state.copyWith(selectedAccountModel: selectedAccount));
    }
  }

  Future<void> _onClearSelectedAccount(
      ClearSelectedAccount event, Emitter<UserState> emit) async {
    emit(state.copyWith(
        selectedAccountModel: null, userInfo: null, clearUserInfo: true));
  }
}
