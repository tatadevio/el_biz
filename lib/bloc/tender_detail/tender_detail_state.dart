part of 'tender_detail_bloc.dart';

sealed class TenderDetailState extends Equatable {
  const TenderDetailState();

  @override
  List<Object> get props => [];
}

final class TenderDetailInitial extends TenderDetailState {}

class TenderDetailLoading extends TenderDetailState {}

class TenderDetailSuccess extends TenderDetailState {
  final TenderDetailModel tenderDetailModel;

  const TenderDetailSuccess({required this.tenderDetailModel});
}

class TenderDetailError extends TenderDetailState {}
