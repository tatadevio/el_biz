import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/data/model/response/company/company_detail_model.dart';
import 'package:el_biz/data/repo/company_detail_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_document_model.dart';
import '../../data/model/response/company/company_product_model.dart';
import '../../data/model/response/company/company_reviews_model.dart';
import '../../data/model/response/company/company_tenders_model.dart';
import '../../data/model/response/tender/tender_item_model.dart';

part 'company_detail_event.dart';
part 'company_detail_state.dart';

class CompanyDetailBloc extends Bloc<CompanyDetailEvent, CompanyDetailState> {
  final CompnayDetailRepo compnayDetailRepo;
  CompanyDetailBloc(this.compnayDetailRepo) : super(CompanyDetailState()) {
    on<GetCompanyDetail>(_onGetCompanyDetail);
    on<GetCompanyDocuments>(_onGetCompanyDocuments);

    on<GetCompanyProducts>(_onGetCompanyProducts);
    on<GetCompanyInactiveProducts>(_onGetCompanyInactiveProducts);

    on<GetCompanyTenders>(_onGetCompanyTenders);
    on<GetCompanyInActiveTenders>(_onGetCompanyInActiveTenders);
    on<GetCompanyReviews>(_onGetCompanyReviews);
    on<DeleteCompanyReview>(_onDeleteCompanyReview);
    on<DeleteCompanyDocument>(_onDeleteCompanyDocument);
    on<AddCompanyReviewReply>(_onAddCompanyReviewReply);
    // on<CompanyDetailEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ToggleFavoriteProduct>(_onToggleFavoriteProduct);
    on<ToggleFavoriteProductInList>(_onToggleFavoriteProductInList);
    on<ToggleTenderFavorite>(_onToggleTenderFavorite);
    on<ToggleFavoriteTenderInList>(_onToggleFavoriteTenderInList);
    on<ChangeProductActiveStatus>(_onChangeProductStatus);
    on<ChangeTenderActiveStatus>(_onChangeTenderStatus);
  }

  Future<void> _onGetCompanyDetail(
      GetCompanyDetail event, Emitter<CompanyDetailState> emit) async {
    emit(state.copyWith(companyDetailLoading: true, isLoading: true));
    add(GetCompanyProducts(event.companyId, currentPage: 1));
    add(GetCompanyDocuments(event.companyId));
    add(GetCompanyTenders(event.companyId, currentPage: 1));
    add(GetCompanyReviews(event.companyId, state.currentPage));
    add(GetCompanyInactiveProducts(event.companyId, currentPage: 1));
    add(GetCompanyInActiveTenders(event.companyId, currentPage: 1));

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
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(productShowMore: true));
    }
    try {
      final response = await compnayDetailRepo.companyProducts(
          event.companyId, 'published', event.currentPage);

      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            companyProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(companyProducts: [
            ...state.companyProducts ?? [],
            ...companyProducts.data?.items ?? []
          ]));
        }

        emit(state.copyWith(
            productCurrentPage: companyProducts.data?.currentPage ?? 1,
            productPageSize: companyProducts.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, productShowMore: false));
  }

  // inactive product

  Future<void> _onGetCompanyInactiveProducts(GetCompanyInactiveProducts event,
      Emitter<CompanyDetailState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(inActiveProductShowMore: true));
    }
    try {
      final response = await compnayDetailRepo.companyProducts(
          event.companyId, 'draft', event.currentPage);

      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            companyInactiveProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(companyInactiveProducts: [
            ...state.companyInactiveProducts ?? [],
            ...companyProducts.data?.items ?? []
          ]));
        }

        emit(state.copyWith(
            inActiveProductCurrentPage: companyProducts.data?.currentPage ?? 1,
            inActiveProductPageSize: companyProducts.data?.totalPages ?? 1));
        // print(
        //     'this is the in active current page : ${companyProducts.data?.currentPage} and length : ${state.companyInactiveProducts?.length}');
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, inActiveProductShowMore: false));
  }

  // end inactive products

  Future<void> _onGetCompanyTenders(
      GetCompanyTenders event, Emitter<CompanyDetailState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, companyTenders: []));
    } else {
      if (state.activeTenderShowMore) {
        return;
      }
      emit(state.copyWith(
        activeTenderShowMore: true,
      ));
    }
    try {
      final response = await compnayDetailRepo.companyTenders(
          event.companyId, 'active', event.currentPage);
      if (response.statusCode == 200) {
        final companyTenders = CompanyTendersModel.fromJson(response.body);
        if (event.currentPage == 1) {
          emit(state.copyWith(
            companyTenders: companyTenders.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(companyTenders: [
            ...state.companyTenders ?? [],
            ...companyTenders.data?.items ?? []
          ]));
        }
        emit(state.copyWith(
            activeTenderCurrentPage: companyTenders.data?.currentPage ?? 1,
            activeTenderPageSize: companyTenders.data?.totalPages ?? 1));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, activeTenderShowMore: false));
    }
    emit(state.copyWith(isLoading: false, activeTenderShowMore: false));
  }

  //_onGetCompanyInActiveTenders
  Future<void> _onGetCompanyInActiveTenders(
      GetCompanyInActiveTenders event, Emitter<CompanyDetailState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      if (state.inActiveTenderShowMore) {
        return;
      }
      emit(state.copyWith(inActiveTenderShowMore: true));
    }
    try {
      final response = await compnayDetailRepo.companyTenders(
          event.companyId, 'inactive', event.currentPage);

      if (response.statusCode == 200) {
        final companyTenders = CompanyTendersModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            companyInactiveTenders: companyTenders.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(companyInactiveTenders: [
            ...state.companyInactiveTenders ?? [],
            ...companyTenders.data?.items ?? []
          ]));
        }

        emit(state.copyWith(
            inActiveTenderCurrentPage: companyTenders.data?.currentPage ?? 1,
            inActiveTenderPageSize: companyTenders.data?.totalPages ?? 1));

       
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, inActiveTenderShowMore: false));
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

  Future<void> _onToggleFavoriteProduct(
      ToggleFavoriteProduct event, Emitter<CompanyDetailState> emit) async {
    final updatedProducts = state.companyProducts!.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    final updatedInactiveProducts =
        state.companyInactiveProducts!.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(
        companyProducts: updatedProducts,
        companyInactiveProducts: updatedInactiveProducts));
    try {
      final response =
          await compnayDetailRepo.toggleFavorite(event.productId.toString());
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        event.context
            .read<FavoriteBloc>()
            .add(RemoveProductFromFavoriteList(event.productId));
      } else {
        final updatedProducts = state.companyProducts!.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        final updatedInactiveProducts =
            state.companyInactiveProducts!.map((product) {
          if (product.id == event.productId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(
            companyProducts: updatedProducts,
            companyInactiveProducts: updatedInactiveProducts));
      }
    } catch (e) {
      final updatedProducts = state.companyProducts!.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      final updatedInactiveProducts =
          state.companyInactiveProducts!.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(
          companyProducts: updatedProducts,
          companyInactiveProducts: updatedInactiveProducts));
    }
  }

  Future<void> _onToggleFavoriteProductInList(ToggleFavoriteProductInList event,
      Emitter<CompanyDetailState> emit) async {
    final updatedProducts = state.companyProducts!.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    final updatedInactiveProducts = state.companyProducts!.map((product) {
      if (product.id == event.productId) {
        return product.copyWith(
          isFavorite: !(product.isFavorite ?? false),
        );
      }
      return product;
    }).toList();

    emit(state.copyWith(
        companyProducts: updatedProducts,
        companyInactiveProducts: updatedInactiveProducts));
  }

  Future<void> _onToggleTenderFavorite(
      ToggleTenderFavorite event, Emitter<CompanyDetailState> emit) async {
    try {
      final updatedTenders = state.companyTenders?.map((tender) {
        if (tender.id == event.tenderId) {
          return tender.copyWith(
            isFavorite: !(tender.isFavorite ?? false),
            image: tender.image ?? '',
          );
        }
        return tender;
      }).toList();

      final updatedInactiveTenders =
          state.companyInactiveTenders?.map((tender) {
        if (tender.id == event.tenderId) {
          return tender.copyWith(
            isFavorite: !(tender.isFavorite ?? false),
          );
        }
        return tender;
      }).toList();

      emit(state.copyWith(
          companyTenders: updatedTenders,
          companyInactiveTenders: updatedInactiveTenders));
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await compnayDetailRepo
          .toggleFavorite(event.tenderId.toString(), type: "Tender");
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        // event.context
        //     .read<FavoriteBloc>()
        //     .add(RemoveProductFromFavoriteList(event.tenderId));
      } else {
        final updatedTenders = state.companyTenders?.map((product) {
          if (product.id == event.tenderId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();

        final updatedInactiveTenders =
            state.companyInactiveTenders?.map((product) {
          if (product.id == event.tenderId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(
            companyTenders: updatedTenders,
            companyInactiveTenders: updatedInactiveTenders));
      }
    } catch (e) {
      final updatedTenders = state.companyTenders!.map((product) {
        if (product.id == event.tenderId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();

      final updatedInactiveTenders =
          state.companyInactiveTenders!.map((product) {
        if (product.id == event.tenderId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(
          companyTenders: updatedTenders,
          companyInactiveTenders: updatedInactiveTenders));
    }
  }

  Future<void> _onToggleFavoriteTenderInList(ToggleFavoriteTenderInList event,
      Emitter<CompanyDetailState> emit) async {
    final updatedTender = state.companyTenders?.map((tender) {
      if (tender.id == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    final updatedInactiveTender = state.companyInactiveTenders?.map((tender) {
      if (tender.id == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(
        companyTenders: updatedTender,
        companyInactiveTenders: updatedInactiveTender));
  }

  Future<void> _onChangeProductStatus(
    ChangeProductActiveStatus event,
    Emitter<CompanyDetailState> emit,
  ) async {
    // Clone lists so we don’t mutate the state directly:
    final active = List<ProductListItem>.from(state.companyProducts ?? []);
    final inactive =
        List<ProductListItem>.from(state.companyInactiveProducts ?? []);

    // Find & remove the item from whichever list it’s in:
    ProductListItem? moved;
    if (event.updatedStatus == 'draft') {
      // Active → Inactive
      for (var p in active) {
        if (p.id.toString() == event.productId.toString()) {
          moved = p;
          break;
        }
      }
      active.removeWhere((p) => p.id.toString() == event.productId.toString());
      if (moved != null) {
        inactive.insert(0, moved);
      }
    } else {
      // Inactive → Active
      for (var p in inactive) {
        if (p.id.toString() == event.productId.toString()) {
          moved = p;
          break;
        }
      }
      inactive
          .removeWhere((p) => p.id.toString() == event.productId.toString());
      if (moved != null) {
        active.insert(0, moved);
      }
    }

    emit(state.copyWith(
      companyProducts: active,
      companyInactiveProducts: inactive,
    ));
  }

  Future<void> _onChangeTenderStatus(
    ChangeTenderActiveStatus event,
    Emitter<CompanyDetailState> emit,
  ) async {
    // Clone lists so we don’t mutate the state directly:
    print(
        'this is the status of the tender status chang e= ${event.updatedStatus}');
    final active = List<TenderItem>.from(state.companyTenders ?? []);
    final inactive = List<TenderItem>.from(state.companyInactiveTenders ?? []);

    // Find & remove the item from whichever list it’s in:
    TenderItem? moved;
    if (event.updatedStatus == 'inactive') {
      // Active → Inactive
      for (var p in active) {
        if (p.id.toString() == event.tenderId.toString()) {
          moved = p;
          break;
        }
      }
      active.removeWhere((p) => p.id.toString() == event.tenderId.toString());
      if (moved != null) {
        inactive.insert(0, moved);
      }
    } else {
      // Inactive → Active
      for (var p in inactive) {
        if (p.id.toString() == event.tenderId.toString()) {
          moved = p;
          break;
        }
      }
      inactive.removeWhere((p) => p.id.toString() == event.tenderId.toString());
      if (moved != null) {
        active.insert(0, moved);
      }
    }

    emit(state.copyWith(
      companyTenders: active,
      companyInactiveTenders: inactive,
    ));
  }
}
