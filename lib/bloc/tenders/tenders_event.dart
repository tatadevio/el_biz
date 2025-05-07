import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

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

class PickImageDocs extends TendersEvent {}

class PickImageDocsCamera extends TendersEvent {}

class RemoveGallery extends TendersEvent {
  final XFile image;
  const RemoveGallery(this.image);

  @override
  List<Object> get props => [image];
}

class ResetNewTenderModel extends TendersEvent {}
