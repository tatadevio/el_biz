part of 'public_tender_bloc.dart';

sealed class PublicTenderEvent extends Equatable {
  const PublicTenderEvent();

  @override
  List<Object> get props => [];
}

class GetPublicTender extends PublicTenderEvent {
  final int currentPage;

  const GetPublicTender(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class TogglePublicTenderFavorite extends PublicTenderEvent {
  final int tenderId;
  const TogglePublicTenderFavorite(this.tenderId);

  @override
  List<Object> get props => [tenderId];
}

class ToggleFavoritePublicTenderInList extends PublicTenderEvent {
  final int tenderId;
  const ToggleFavoritePublicTenderInList({required this.tenderId});

  @override
  List<Object> get props => [tenderId];
}
