part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotification extends NotificationEvent {
  final int currentPage;
  const GetNotification(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class ReadNotification extends NotificationEvent {
  final String notificationId;
  const ReadNotification(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}
