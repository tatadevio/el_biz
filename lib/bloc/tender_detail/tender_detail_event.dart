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
