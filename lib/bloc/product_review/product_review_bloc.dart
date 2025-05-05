import 'package:el_biz/data/repo/product_review_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_reviews_model.dart';
import '../../data/model/response/product/product_review_model.dart';

part 'product_review_event.dart';
part 'product_review_state.dart';

class ProductReviewBloc extends Bloc<ProductReviewEvent, ProductReviewState> {
  final ProductReviewRepo productReviewRepo;
  ProductReviewBloc(this.productReviewRepo)
      : super(ProductReviewState(productReviewsModel: ProductReviewsModel())) {
    on<ProductReviewEvent>((event, emit) {});

    on<GetProductReviews>(_onGetProductReviews);
    on<DeleteProductReview>(_onDeleteProductReview);
    on<AddProductReviewReply>(_onAddProductReviewReply);
  }

  Future<void> _onGetProductReviews(
      GetProductReviews event, Emitter<ProductReviewState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, productReviews: []));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final response = await productReviewRepo.productReviews(
          event.productId, event.currentPage);
      if (response.statusCode == 200) {
        final myProductReviews = ProductReviewsModel.fromJson(response.body);
        emit(state.copyWith(
          productReviews: List<ProductReviewItem>.from(state.productReviews)
            ..addAll(myProductReviews.data?.items ?? []),
          // myProductReviews.data?.items,
          productReviewsModel: myProductReviews,
          currentPage: myProductReviews.data?.currentPage ?? 1,
          pageSize: myProductReviews.data?.totalPages ?? 1,
          isLoading: false,
          isMoreLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false, isMoreLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isMoreLoading: false));
    }
  }

  Future<void> _onAddProductReviewReply(
    AddProductReviewReply event,
    Emitter<ProductReviewState> emit,
  ) async {
    print(
        'this is event : ${event.index} and ${event.reply} and ${event.reviewId}');

    if (state.productReviews.isNotEmpty) {
      // Create a new list from the current reviews
      final updatedReviews = List<ProductReviewItem>.from(state.productReviews);

      // Get the current review to update
      ProductReviewItem currentReview = updatedReviews[event.index];

      // Create a new list of replies (avoid mutating the original)
      final updatedReplies = List<Reply>.from(currentReview.answers ?? []);
      updatedReplies.add(
        Reply(
          answer: event.reply,
          createdAt: DateTime.now(),
        ),
      );

      // Create a new review with updated replies
      final updatedReview = currentReview.copyWith(answers: updatedReplies);

      // Replace the review in the list
      updatedReviews[event.index] = updatedReview;

      // Emit the updated state
      emit(state.copyWith(productReviews: updatedReviews));
    }

    // Send the reply to the backend
    try {
      final response = await productReviewRepo.addProductReviewReply(
        event.reviewId,
        event.reply,
      );
      if (response.statusCode == 200) {
        // success - already updated UI optimistically
      } else {
        // handle error if needed
      }
    } catch (e) {
      // log or handle error
    }
  }

  Future<void> _onDeleteProductReview(
      DeleteProductReview event, Emitter<ProductReviewState> emit) async {
    try {
      final response =
          await productReviewRepo.deleteProductReview(event.reviewId);

      if (response.statusCode == 200) {
        final updatedReviews = state.productReviews
            .where((review) => review.id.toString() != event.reviewId)
            .toList();

        emit(state.copyWith(productReviews: updatedReviews));

        final response =
            await productReviewRepo.productReviews(event.productId, 1);
        if (response.statusCode == 200) {
          final companyReviews = ProductReviewsModel.fromJson(response.body);
          emit(state.copyWith(productReviewsModel: companyReviews));
        }
      }
    } catch (e) {
      // Optionally log the error
      debugPrint("Error deleting review: $e");
    }
  }
}
