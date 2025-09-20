part of 'add_auction_bloc.dart';

sealed class AddAuctionState extends Equatable {
  const AddAuctionState();

  @override
  List<Object> get props => [];
}

final class AddAuctionInitial extends AddAuctionState {}

class AddAuctionLoader extends AddAuctionState {}

class AddAuctionError extends AddAuctionState {
  final String error;
  const AddAuctionError(this.error);
}

final class AddAuctionSuccess extends AddAuctionState {
  final AuctionListItem auction;
  const AddAuctionSuccess(this.auction);
}
