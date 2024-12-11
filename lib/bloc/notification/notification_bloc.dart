import 'package:el_biz/data/repo/notification_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo notificationRepo;
  NotificationBloc(this.notificationRepo) : super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
