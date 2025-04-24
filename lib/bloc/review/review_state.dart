part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final bool isLoading;
  final List<XFile> pickedLogo;
  final List? myReviews;
  // final bool isMoreLoading;
  // final int currentPage;
  // final int pageSize;

  const ReviewState({
    this.isLoading = false,
    this.pickedLogo = const [],
    this.myReviews = const [],
    // this.isMoreLoading = false,
    // this.currentPage = 1,
    // this.pageSize = 1,
  });

  ReviewState copywith({
    bool? isLoading,
    List<XFile>? pickedLogo,
    List? myReviews,
    // bool? isMoreLoading,
    // int? currentPage,
    // int? pageSize,
  }) {
    return ReviewState(
      isLoading: isLoading ?? this.isLoading,
      pickedLogo: pickedLogo ?? this.pickedLogo,
      myReviews: myReviews ?? this.myReviews,
      // isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      // currentPage: currentPage ?? this.currentPage,
      // pageSize: pageSize ?? this.pageSize
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        pickedLogo,
        myReviews ?? [],
        // isMoreLoading,
        // currentPage,
        // pageSize,
      ];
}

// final class ReviewInitial extends ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {}

class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);

  @override
  List<Object> get props => [message];
}

class ReviewPickedImages extends ReviewState {
  final List<XFile> pickedLogo;
  const ReviewPickedImages(this.pickedLogo);

  @override
  List<Object> get props => [pickedLogo];
}
