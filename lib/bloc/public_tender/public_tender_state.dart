part of 'public_tender_bloc.dart';

class PublicTenderState extends Equatable {
  final bool isLoading;
  final List<TenderItem> publicTenders;
  final bool isMoreLoading;
  final int tenderCurrentPage;
  final int tenderPageSize;
  const PublicTenderState(
      {this.isLoading = false,
      this.publicTenders = const [],
      this.isMoreLoading = false,
      this.tenderCurrentPage = 1,
      this.tenderPageSize = 1});

  PublicTenderState copyWith({
    bool? isLoading,
    List<TenderItem>? publicTenders,
    bool? isMoreLoading,
    int? tenderCurrentPage,
    int? tenderPageSize,
  }) {
    return PublicTenderState(
      isLoading: isLoading ?? this.isLoading,
      publicTenders: publicTenders ?? this.publicTenders,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      tenderCurrentPage: tenderCurrentPage ?? this.tenderCurrentPage,
      tenderPageSize: tenderPageSize ?? this.tenderPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        publicTenders,
        isMoreLoading,
        tenderCurrentPage,
        tenderPageSize
      ];
}

final class PublicTenderInitial extends PublicTenderState {}
