part of 'tender_detail_bloc.dart';

class TenderDetailState extends Equatable {
  final bool statusUpdating;
  final TenderDetailModel? tenderDetailModel;
  const TenderDetailState(
      {this.statusUpdating = false, this.tenderDetailModel});

  TenderDetailState copyWith(
      {bool? statusUpdating, TenderDetailModel? tenderDetailModel}) {
    return TenderDetailState(
      statusUpdating: statusUpdating ?? this.statusUpdating,
      tenderDetailModel: tenderDetailModel?? this.tenderDetailModel,
    );
  }

  @override
  List<Object> get props => [statusUpdating, tenderDetailModel!];
}

final class TenderDetailInitial extends TenderDetailState {
  TenderDetailInitial() : super(tenderDetailModel: TenderDetailModel());
}

class TenderDetailLoading extends TenderDetailState {}

// class TenderDetailSuccess extends TenderDetailState {
//   final TenderDetailModel tenderDetailModel;

//   const TenderDetailSuccess({required this.tenderDetailModel});
// }

class TenderDetailError extends TenderDetailState {}
