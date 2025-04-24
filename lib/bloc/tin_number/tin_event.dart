part of 'tin_bloc.dart';

sealed class TinEvent extends Equatable {
  const TinEvent();

  @override
  List<Object> get props => [];
}

class VerifyTinNumber extends TinEvent {
  final String tinNumber;
  const VerifyTinNumber({required this.tinNumber});

  @override
  List<Object> get props => [tinNumber];
}
