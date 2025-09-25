part of 'auction_detail_bloc.dart';

class AuctionDetailState extends Equatable {
  const AuctionDetailState();

  @override
  List<Object> get props => [];
}

final class AuctionDetailInitial extends AuctionDetailState {}

final class AuctionDetailLoading extends AuctionDetailState {}

final class AuctionDetailLoaderInvisible extends AuctionDetailState {}

final class AuctionDetailError extends AuctionDetailState {
  final String error;
  const AuctionDetailError(this.error);
}

final class AuctionDetailSuccess extends AuctionDetailState {
  final AuctionDetailModel auctionDetailModel;
  const AuctionDetailSuccess(this.auctionDetailModel);
}
