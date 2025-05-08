import 'package:el_biz/data/repo/public_tender_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_tenders_model.dart';
import '../../data/model/response/tender/tender_item_model.dart';

part 'public_tender_event.dart';
part 'public_tender_state.dart';

class PublicTenderBloc extends Bloc<PublicTenderEvent, PublicTenderState> {
  final PublicTenderRepo publicTenderRepo;
  PublicTenderBloc(this.publicTenderRepo) : super(PublicTenderState()) {
    on<PublicTenderEvent>((event, emit) {});
    on<GetPublicTender>(_onGetPublicTenders);
    on<TogglePublicTenderFavorite>(_onTogglePublicTenderFavorite);
    on<ToggleFavoritePublicTenderInList>(_onToggleFavoritePublicTenderInList);
  }

  Future<void> _onGetPublicTenders(
      GetPublicTender event, Emitter<PublicTenderState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, publicTenders: []));
    } else {
      // emit.is
    }
    try {
      final response = await publicTenderRepo.companyTenders(event.currentPage);
      if (response.statusCode == 200) {
        final companyTenders = CompanyTendersModel.fromJson(response.body);
        emit(state.copyWith(
          publicTenders: List<TenderItem>.from(state.publicTenders)
            ..addAll(companyTenders.data?.items ?? []),
          isLoading: false,
          tenderCurrentPage: companyTenders.data?.currentPage ?? 1,
          tenderPageSize: companyTenders.data?.totalPages ?? 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onTogglePublicTenderFavorite(
      TogglePublicTenderFavorite event, Emitter<PublicTenderState> emit) async {
    final updatedProducts = state.publicTenders.map((tender) {
      if (tender.id == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(publicTenders: updatedProducts));
    try {
      final response = await publicTenderRepo
          .toggleFavorite(event.tenderId.toString(), type: "Tender");
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        // event.context
        //     .read<FavoriteBloc>()
        //     .add(RemoveProductFromFavoriteList(event.tenderId));
      } else {
        final updatedProducts = state.publicTenders.map((product) {
          if (product.id == event.tenderId) {
            return product.copyWith(
              isFavorite: !(product.isFavorite ?? false),
            );
          }
          return product;
        }).toList();
        emit(state.copyWith(publicTenders: updatedProducts));
      }
    } catch (e) {
      final updatedProducts = state.publicTenders.map((product) {
        if (product.id == event.tenderId) {
          return product.copyWith(
            isFavorite: !(product.isFavorite ?? false),
          );
        }
        return product;
      }).toList();
      emit(state.copyWith(publicTenders: updatedProducts));
    }
  }

  Future<void> _onToggleFavoritePublicTenderInList(
      ToggleFavoritePublicTenderInList event,
      Emitter<PublicTenderState> emit) async {
    final updatedTender = state.publicTenders.map((tender) {
      if (tender.id == event.tenderId) {
        return tender.copyWith(
          isFavorite: !(tender.isFavorite ?? false),
        );
      }
      return tender;
    }).toList();

    emit(state.copyWith(publicTenders: updatedTender));
  }
}
