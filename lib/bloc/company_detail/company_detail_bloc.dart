import 'package:el_biz/data/model/response/company/company_detail_model.dart';
import 'package:el_biz/data/repo/company_detail_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_document_model.dart';
import '../../data/model/response/company/company_product_model.dart';
import '../../data/model/response/company/company_reviews_model.dart';
import '../../data/model/response/company/company_tenders_model.dart';
import '../../data/model/response/product/product_model.dart';
import '../../data/model/response/tender/tender_item_model.dart';

part 'company_detail_event.dart';
part 'company_detail_state.dart';

class CompanyDetailBloc extends Bloc<CompanyDetailEvent, CompanyDetailState> {
  final CompnayDetailRepo compnayDetailRepo;
  CompanyDetailBloc(this.compnayDetailRepo) : super(CompanyDetailState()) {
    on<GetCompanyDetail>(_onGetCompanyDetail);
    on<GetCompanyDocuments>(_onGetCompanyDocuments);

    on<GetCompanyProducts>(_onGetCompanyProducts);
    on<GetCompanyTenders>(_onGetCompanyTenders);
    on<GetCompanyReviews>(_onGetCompanyReviews);
    on<DeleteCompanyDocument>(_onDeleteCompanyDocument);
    on<AddCompanyReviewReply>(_onAddCompanyReviewReply);
    on<DeleteCompanyReview>(_onDeleteCompanyReview);
    // on<CompanyDetailEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  Future<void> _onGetCompanyDetail(
      GetCompanyDetail event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(companyDetailLoading: true, isLoading: true));
    add(GetCompanyProducts(event.companyId));
    add(GetCompanyDocuments(event.companyId));
    add(GetCompanyTenders(event.companyId));
    add(GetCompanyReviews(event.companyId, state.currentPage));
    try {
      final response =
          await compnayDetailRepo.companyDetailById(event.companyId);
      if (response.statusCode == 200) {
        final companyDetail = CompanyDetailModel.fromJson(response.body);
        print('this is company detail : ${companyDetail.toJson()}');
        // emit(state.copyWith(companyDetailModel: companyDetail));
        emit(state.copyWith(
          companyDetailModel: companyDetail,
          isLoading: false,
          companyDetailLoading: false,
        ));
        print('this is company detail after emit : ${companyDetail.message}');
      } else {
        emit(state.copyWith(
          isLoading: false,
          companyDetailLoading: false,
        ));
      }
    } catch (e) {
      print('Error: $e');
      emit(state.copyWith(
        isLoading: false,
        companyDetailLoading: false,
      ));
    }
  }

  Future<void> _onGetCompanyProducts(
      GetCompanyProducts event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await compnayDetailRepo.companyProducts(event.companyId);
      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);
        print('this is company products : ${companyProducts.toJson()}');
        emit(state.copyWith(
          companyProducts: companyProducts.data?.items,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {}
  }

  Future<void> _onGetCompanyTenders(
      GetCompanyTenders event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await compnayDetailRepo.companyTenders(event.companyId);
      if (response.statusCode == 200) {
        final companyTenders = CompanyTendersModel.fromJson(response.body);
        emit(state.copyWith(
          companyTenders: companyTenders.data?.items,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGetCompanyReviews(
      GetCompanyReviews event, Emitter<CompanyDetailState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, companyReviews: []));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final response = await compnayDetailRepo.companyReviews(
          event.companyId, event.currentPage);
      if (response.statusCode == 200) {
        final companyReviews = CompanyReviewsModel.fromJson(response.body);
        emit(state.copyWith(
          companyReviews: List<ReviewItem>.from(state.companyReviews ?? [])
            ..addAll(companyReviews.data?.items ?? []),
          // companyReviews.data?.items,
          companyReviewsModel: companyReviews,
          currentPage: companyReviews.data?.currentPage ?? 1,
          pageSize: companyReviews.data?.totalPages ?? 1,
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

  Future<void> _onAddCompanyReviewReply(
    AddCompanyReviewReply event,
    Emitter<CompanyDetailState> emit,
  ) async {
    print(
        'this is event : ${event.index} and ${event.reply} and ${event.reviewId}');

    if (state.companyReviews != null && state.companyReviews!.isNotEmpty) {
      // Create a new list from the current reviews
      final updatedReviews = List<ReviewItem>.from(state.companyReviews!);

      // Get the current review to update
      ReviewItem currentReview = updatedReviews[event.index];

      // Create a new list of replies (avoid mutating the original)
      final updatedReplies = List<Reply>.from(currentReview.reply ?? []);
      updatedReplies.add(
        Reply(
          answer: event.reply,
          createdAt: DateTime.now(),
        ),
      );

      // Create a new review with updated replies
      final updatedReview = currentReview.copyWith(reply: updatedReplies);

      // Replace the review in the list
      updatedReviews[event.index] = updatedReview;

      // Emit the updated state
      emit(state.copyWith(companyReviews: updatedReviews));
    }

    // Send the reply to the backend
    try {
      final response = await compnayDetailRepo.addCompanyReviewReply(
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

  Future<void> _onDeleteCompanyReview(
      DeleteCompanyReview event, Emitter<CompanyDetailState> emit) async {
    try {
      final response =
          await compnayDetailRepo.deleteCompanyReview(event.reviewId);

      if (response.statusCode == 200) {
        final updatedReviews = state.companyReviews!
            .where((review) => review.id.toString() != event.reviewId)
            .toList();

        emit(state.copyWith(companyReviews: updatedReviews));
        final response = await compnayDetailRepo.companyReviews(
            state.companyDetailModel?.data?.id.toString() ?? '', 1);
        if (response.statusCode == 200) {
          final companyReviews = CompanyReviewsModel.fromJson(response.body);
          emit(state.copyWith(companyReviewsModel: companyReviews));
        }
      }
    } catch (e) {
      // Optionally log the error
      debugPrint("Error deleting review: $e");
    }
  }

  // Future<void> _onAddCompanyReviewReply(
  //     AddCompanyReviewReply event, Emitter<CompanyDetailState> emit) async {
  //   // emit(state.copyWith(isLoading: true));
  //   print(
  //       'this is event : ${event.index} and ${event.reply} and ${event.reviewId}');
  //   if (state.companyReviews != null && state.companyReviews!.isNotEmpty) {
  //     final updatedReviews = List<ReviewItem>.from(state.companyReviews!);
  //     final reviewToUpdate = updatedReviews[event.index];

  //     if (reviewToUpdate.reply == null) {
  //       reviewToUpdate.reply = [];
  //     }

  //     reviewToUpdate.reply!.add(Reply(
  //       answer: event.reply,
  //       createdAt: DateTime.now(),
  //     ));

  //     emit(state.copyWith(
  //       companyReviews: updatedReviews,
  //     ));
  //   }

  //   try {
  //     final response = await compnayDetailRepo.addCompanyReviewReply(
  //         event.reviewId, event.reply);
  //     if (response.statusCode == 200) {
  //       // emit(state.copyWith(isLoading: false));
  //     } else {
  //       // emit(state.copyWith(isLoading: false));
  //     }
  //   } catch (e) {
  //     // emit(state.copyWith(isLoading: false));
  //   }
  // }

  Future<void> _onGetCompanyDocuments(
      GetCompanyDocuments event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response =
          await compnayDetailRepo.companyDocuments(event.companyId);
      if (response.statusCode == 200) {
        final companyDocuments = CompanyDocumentModel.fromJson(response.body);
        emit(state.copyWith(
          companyDocuments: companyDocuments.data?.items,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteCompanyDocument(
      DeleteCompanyDocument event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response =
          await compnayDetailRepo.deleteCompanyDocument(event.documentId);
      if (response.statusCode == 200) {
        // emit(state.copyWith(isLoading: false));
        state.companyDocuments?.removeWhere(
            (element) => element.id.toString() == event.documentId);
        emit(state.copyWith(
            companyDocuments: state.companyDocuments, isLoading: false));
      }
    } catch (e) {
      print('Error: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
