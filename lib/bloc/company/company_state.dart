part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final bool isLoading;
  final List<ComapnyDocumentModel> companyDocuments;
  final bool isShowActiveGoods;
  final bool isShowActiveTenders;
  final bool isShowGoodsGridView;
  final bool isShowTendersGridView;
  final List<DaySchedule> scheduleTiming;
  final AddCompanyModel addCompanyModel;
  const CompanyState({
    this.isLoading = false,
    this.companyDocuments = const [],
    this.isShowActiveGoods = true,
    this.isShowActiveTenders = true,
    this.isShowGoodsGridView = true,
    this.isShowTendersGridView = true,
    this.scheduleTiming = const [],
    required this.addCompanyModel ,
  });

  CompanyState copywith(
      {bool? isLoading,
      List<ComapnyDocumentModel>? companyDocuments,
      bool? isShowActiveGoods,
      bool? isShowActiveTenders,
      bool? isShowGoodsGridView,
      bool? isShowTendersGridView,
      List<DaySchedule>? scheduleTiming,
      AddCompanyModel? addCompanyModel}) {
    return CompanyState(
      isLoading: isLoading ?? this.isLoading,
      companyDocuments: companyDocuments ?? this.companyDocuments,
      isShowActiveGoods: isShowActiveGoods ?? this.isShowActiveGoods,
      isShowActiveTenders: isShowActiveTenders ?? this.isShowActiveTenders,
      isShowGoodsGridView: isShowGoodsGridView ?? this.isShowGoodsGridView,
      isShowTendersGridView:
          isShowTendersGridView ?? this.isShowTendersGridView,
      scheduleTiming: scheduleTiming ?? this.scheduleTiming,
      addCompanyModel: addCompanyModel ?? this.addCompanyModel,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        companyDocuments,
        isShowActiveGoods,
        isShowActiveTenders,
        isShowGoodsGridView,
        isShowTendersGridView,
        scheduleTiming,
        addCompanyModel as AddCompanyModel
      ];
}

// final class CompanyInitial extends CompanyState {}
