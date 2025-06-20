part of 'public_tender_bloc.dart';

sealed class PublicTenderEvent extends Equatable {
  const PublicTenderEvent();

  @override
  List<Object> get props => [];
}

class GetPublicTender extends PublicTenderEvent {
  final int currentPage;
  final String? direction;

  const GetPublicTender(this.currentPage, {required this.direction});

  @override
  List<Object> get props => [currentPage, direction ?? 'asc'];
}

class TogglePublicTenderFavorite extends PublicTenderEvent {
  final int tenderId;
  final BuildContext context;
  const TogglePublicTenderFavorite(this.tenderId, this.context);

  @override
  List<Object> get props => [tenderId];
}

class ToggleFavoritePublicTenderInList extends PublicTenderEvent {
  final int tenderId;
  const ToggleFavoritePublicTenderInList({required this.tenderId});

  @override
  List<Object> get props => [tenderId];
}


class UpdateTenderFilterEnable extends PublicTenderEvent {
  final bool isEnable;
  const UpdateTenderFilterEnable(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class FilterPublicTenderProduct extends PublicTenderEvent {
  final TenderFilterValuesModel productFilterValuesModel;
  final int currentPage;
  const FilterPublicTenderProduct({
    required this.productFilterValuesModel,
    required this.currentPage,
  });

  @override
  List<Object> get props => [
        productFilterValuesModel,
        currentPage,
      ];
}
