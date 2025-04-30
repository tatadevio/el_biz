import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../data/model/response/userinfo_model.dart';
import '../../data/repo/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;
  UserBloc(this.userRepo) : super(UserInitial()) {
    on<GetUserInfo>((event, emit) async {
      final res = await userRepo.getUserInfo();
      print('====> User Info: ${res.body}');
      UserInfoModel userInfo = UserInfoModel.fromJson(res.body);
      emit(state.copyWith(userInfo: userInfo));
    });

    // on<UserEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<UpdateUserData>(_onUpdateUserData);
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

        emit(state.copyWith(
          userInfo: state.userInfo?.copyWith(data: userData) ??
              UserInfoModel(data: userData),
        ));
        // add(GetUserInfo());
      } else {
        emit(UpdateUserDataError(error: 'error'.tr));
      }
    } catch (e) {
      emit(UpdateUserDataError(error: e.toString()));
    }

    emit(state.copyWith(isLoading: false));
  }
}
