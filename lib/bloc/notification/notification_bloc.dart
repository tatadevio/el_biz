import 'package:el_biz/data/model/response/notification/notifications_model.dart';
import 'package:el_biz/data/repo/notification_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo notificationRepo;
  NotificationBloc(this.notificationRepo) : super(const NotificationState()) {
    on<NotificationEvent>((event, emit) {});
    on<GetNotification>(_onGetNotification);
    on<ReadNotification>(_onReadNotification);
  }

  Future<void> _onGetNotification(
      GetNotification event, Emitter<NotificationState> emit) async {
    print('call get notification with page = ${event.currentPage}');
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final response =
          await notificationRepo.getNotifications(event.currentPage);
      if (response.statusCode == 200) {
        NotificationsModel notificationsModel =
            NotificationsModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(notificationsList: []));
        }
        emit(state.copyWith(
            notificationsList:
                List<NotificationItem>.from(state.notificationsList)
                  ..addAll(notificationsModel.data?.items ?? []),
            isLoading: false,
            isMoreLoading: false,
            currentPage: notificationsModel.data?.currentPage ?? 0,
            pageSize: notificationsModel.data?.totalPages ?? 0));
      } else {
        NotificationError(response.body['message']);
      }
    } catch (e) {
      NotificationError(e.toString());
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onReadNotification(
      ReadNotification event, Emitter<NotificationState> emit) async {
    try {
      final response =
          await notificationRepo.readNotification(event.notificationId);
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        // Check if the API response indicates success
        if (response.body['success'] == true) {
          List<NotificationItem> allNotification =
              List.from(state.notificationsList);

          final index = allNotification.indexWhere((notification) =>
              notification.id.toString() == event.notificationId.toString());

          if (index != -1) {
            allNotification[index] =
                allNotification[index].copyWith(isRead: true);
            // .removeAt(index);

            emit(state.copyWith(notificationsList: allNotification));
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
