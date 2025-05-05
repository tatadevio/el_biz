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

class AddReview extends ReviewEvent {
  final String companyId;
  final int rating;
  final String review;
  final List<XFile> images;

  const AddReview({
    required this.companyId,
    required this.rating,
    required this.review,
    required this.images,
  });

  @override
  List<Object> get props => [companyId, rating, review, images];
}


class AddProductReview extends ReviewEvent {
  final String productId;
  final int rating;
  final String review;
  final List<XFile> images;

  const AddProductReview({
    required this.productId,
    required this.rating,
    required this.review,
    required this.images,
  });

  @override
  List<Object> get props => [productId, rating, review, images];
}
