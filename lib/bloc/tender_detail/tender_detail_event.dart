part of 'tender_detail_bloc.dart';

sealed class TenderDetailEvent extends Equatable {
  const TenderDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTenderDetail extends TenderDetailEvent {
  final String tenderId;

  const GetTenderDetail({required this.tenderId});

  @override
  List<Object> get props => [tenderId];
}

class ChangeTenderStatus extends TenderDetailEvent {
  final String tenderId;
  final String status;
  final BuildContext context;
  const ChangeTenderStatus(this.tenderId, this.status, this.context);

  @override
  List<Object> get props => [tenderId, status, context];
}

class ToggleTenderDetailFavorite extends TenderDetailEvent {
  final int tenderId;
  final BuildContext context;
  const ToggleTenderDetailFavorite(
      {required this.tenderId, required this.context});

  @override
  List<Object> get props => [tenderId, context];
}
