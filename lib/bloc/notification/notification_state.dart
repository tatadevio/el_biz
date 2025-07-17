part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final List<NotificationItem> notificationsList;
  final int currentPage;
  final int pageSize;
  const NotificationState(
      {this.isLoading = false,
      this.notificationsList = const [],
      this.currentPage = 1,
      this.pageSize = 1});

  NotificationState copyWith(
      {bool? isLoading,
      List<NotificationItem>? notificationsList,
      int? currentPage,
      int? pageSize}) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notificationsList: notificationsList ?? this.notificationsList,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, notificationsList, currentPage, pageSize];
}

final class NotificationInitial extends NotificationState {}

class NotificationError extends NotificationState {
  final String error;
  const NotificationError(this.error);
}
