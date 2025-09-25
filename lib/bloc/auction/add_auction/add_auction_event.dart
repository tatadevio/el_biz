part of 'add_auction_bloc.dart';

sealed class AddAuctionEvent extends Equatable {
  const AddAuctionEvent();

  @override
  List<Object> get props => [];
}

class AddNewAuction extends AddAuctionEvent {
  final Map<String, String> auctionData;
  const AddNewAuction(this.auctionData);
}
