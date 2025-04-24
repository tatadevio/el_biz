import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
