part of 'tin_bloc.dart';

sealed class TinState extends Equatable {
  const TinState();
  
  @override
  List<Object> get props => [];
}

final class TinInitial extends TinState {}

final class TinLoading extends TinState {}

final class TinSuccess extends TinState {
  final String tinNumber;
  const TinSuccess(this.tinNumber);
}

final class TinError extends TinState {
  final String message;
  const TinError(this.message);
}