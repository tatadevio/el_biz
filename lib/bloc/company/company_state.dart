part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final bool isLoading;
  // final List<ComapnyDocumentModel> companyDocuments;
  final List<CompanyItem> myCompanies;
  final bool isShowActiveGoods;
  final bool isShowActiveTenders;
  final bool isShowGoodsGridView;
  final bool isShowTendersGridView;
  final List<DaySchedule> scheduleTiming;
  final AddCompanyModel addCompanyModel;

  const CompanyState({
    this.isLoading = false,
    // this.companyDocuments = const [],
    this.myCompanies = const [],
    this.isShowActiveGoods = true,
    this.isShowActiveTenders = true,
    this.isShowGoodsGridView = true,
    this.isShowTendersGridView = true,
    this.scheduleTiming = const [],
    required this.addCompanyModel,
  });

  CompanyState copywith(
      {bool? isLoading,
      // List<ComapnyDocumentModel>? companyDocuments,
      List<CompanyItem>? myCompanies,
      bool? isShowActiveGoods,
      bool? isShowActiveTenders,
      bool? isShowGoodsGridView,
      bool? isShowTendersGridView,
      List<DaySchedule>? scheduleTiming,
      AddCompanyModel? addCompanyModel}) {
    return CompanyState(
      isLoading: isLoading ?? this.isLoading,
      // companyDocuments: companyDocuments ?? this.companyDocuments,
      myCompanies: myCompanies ?? this.myCompanies,
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
        // companyDocuments,
        myCompanies,
        isShowActiveGoods,
        isShowActiveTenders,
        isShowGoodsGridView,
        isShowTendersGridView,
        scheduleTiming,
        addCompanyModel as AddCompanyModel,
      ];
}

// final class CompanyInitial extends CompanyState {}

// final class CompanyLoading extends CompanyState {
//   CompanyLoading({required super.addCompanyModel});
// }

// final class CompanySuccess extends CompanyState {
//   CompanySuccess({required super.addCompanyModel});
// }

// final class CompanyFailure extends CompanyState {
//   final String message;
//   const CompanyFailure(, {required super.addCompanyModel}this.message);
// }

//  class CompanyDetail extends CompanyState {
//   final CompanyDetailModel companyDetail;
//    CompanyDetail( {required super.addCompanyModel},this.companyDetail);
// }

// class PaymentOfficeSuccessState extends PaymentStates {
//   final PaymentOfficeModel paymentOfficeModel;
//   final String? tourId;

//   PaymentOfficeSuccessState(this.paymentOfficeModel, this.tourId);
// }
