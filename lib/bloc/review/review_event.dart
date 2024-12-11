part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class PickImageDocs extends ReviewEvent {}

class PickImageDocsCamera extends ReviewEvent {}

class RemoveGallery extends ReviewEvent {
  final XFile image;
  const RemoveGallery(this.image);

  @override
  List<Object> get props => [image];
}
