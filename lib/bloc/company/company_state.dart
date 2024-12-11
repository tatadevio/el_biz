part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final bool isLoading;
  final List<ComapnyDocumentModel> companyDocuments;
  final bool isShowActiveGoods;
  final bool isShowActiveTenders;
  final bool isShowGoodsGridView;
  final bool isShowTendersGridView;
  const CompanyState({this.isLoading = false, this.companyDocuments = const [], this.isShowActiveGoods = true, this.isShowActiveTenders = true, this.isShowGoodsGridView = true, this.isShowTendersGridView = true});

  CompanyState copywith({bool? isLoading, List<ComapnyDocumentModel>? companyDocuments, bool? isShowActiveGoods, bool? isShowActiveTenders, bool? isShowGoodsGridView, bool? isShowTendersGridView}) {
    return CompanyState(
        isLoading: isLoading ?? this.isLoading,
        companyDocuments: companyDocuments ?? this.companyDocuments,
        isShowActiveGoods: isShowActiveGoods ?? this.isShowActiveGoods,
        isShowActiveTenders: isShowActiveTenders ?? this.isShowActiveTenders,
        isShowGoodsGridView: isShowGoodsGridView ?? this.isShowGoodsGridView,
        isShowTendersGridView: isShowTendersGridView ?? this.isShowTendersGridView);
  }

  @override
  List<Object> get props => [isLoading, companyDocuments, isShowActiveGoods, isShowActiveTenders, isShowGoodsGridView, isShowTendersGridView];
}

// final class CompanyInitial extends CompanyState {}
