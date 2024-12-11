part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final bool isLoading;
  final List<XFile> pickedLogo;
  final List? myReviews;

  const ReviewState({
    this.isLoading = false,
    this.pickedLogo = const [],
    this.myReviews = const [],
  });

  ReviewState copywith({bool? isLoading, List<XFile>? pickedLogo, List? myReviews}) {
    return ReviewState(isLoading: isLoading ?? this.isLoading, pickedLogo: pickedLogo ?? this.pickedLogo, myReviews: myReviews ?? this.myReviews);
  }

  @override
  List<Object> get props => [
        isLoading,
        pickedLogo,
        myReviews ?? [],
      ];
}

// final class ReviewInitial extends ReviewState {}
