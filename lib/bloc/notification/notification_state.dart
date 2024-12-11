part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final List notificationsList;
  const NotificationState({this.isLoading = false, this.notificationsList = const []});

  NotificationState copyWith({bool? isLoading, List? notificationsList}) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notificationsList: notificationsList ?? this.notificationsList,
    );
  }

  @override
  List<Object> get props => [isLoading, notificationsList];
}

// final class NotificationInitial extends NotificationState {}
