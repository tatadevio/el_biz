import 'package:equatable/equatable.dart';

abstract class TendersEvent extends Equatable {
  const TendersEvent();

  @override
  List<Object> get props => [];
}

class UpdateGridView extends TendersEvent {
  final bool isGridView;

  const UpdateGridView(this.isGridView);

  @override
  List<Object> get props => [isGridView];
}

class FetchAllTenders extends TendersEvent {}
