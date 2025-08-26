part of 'company_bloc.dart';

class CompanyState extends Equatable {
  final bool isLoading;
  // final List<ComapnyDocumentModel> companyDocuments;
  final List<CompanyItem> myCompanies;
  final bool isShowActiveGoods;
  final bool isShowActiveTenders;
  final bool isShowActiveAuctions;
  final bool isShowGoodsGridView;
  final bool isShowTendersGridView;
  final bool isShowAuctionsGridView;
  final List<DaySchedule> scheduleTiming;
  final AddCompanyModel addCompanyModel;
  final int myCompanyCurrentPage;
  final int myCompanyPageSize;
  final bool myCompanyLoadMore;

  const CompanyState({
    this.isLoading = false,
    // this.companyDocuments = const [],
    this.myCompanies = const [],
    this.isShowActiveGoods = true,
    this.isShowActiveTenders = true,
    this.isShowActiveAuctions = true,
    this.isShowGoodsGridView = true,
    this.isShowTendersGridView = true,
    this.isShowAuctionsGridView = true,
    this.scheduleTiming = const [],
    required this.addCompanyModel,
    this.myCompanyCurrentPage = 1,
    this.myCompanyPageSize = 1,
    this.myCompanyLoadMore = false,
  });

  CompanyState copywith({
    bool? isLoading,
    // List<ComapnyDocumentModel>? companyDocuments,
    List<CompanyItem>? myCompanies,
    bool? isShowActiveGoods,
    bool? isShowActiveTenders,
    bool? isShowActiveAuctions,
    bool? isShowGoodsGridView,
    bool? isShowTendersGridView,
    bool? isShowAuctionsGridView,
    List<DaySchedule>? scheduleTiming,
    AddCompanyModel? addCompanyModel,
    int? myCompanyCurrentPage,
    int? myCompanyPageSize,
    bool? myCompanyLoadMore,
  }) {
    return CompanyState(
      isLoading: isLoading ?? this.isLoading,
      // companyDocuments: companyDocuments ?? this.companyDocuments,
      myCompanies: myCompanies ?? this.myCompanies,
      isShowActiveGoods: isShowActiveGoods ?? this.isShowActiveGoods,
      isShowActiveTenders: isShowActiveTenders ?? this.isShowActiveTenders,
      isShowActiveAuctions: isShowActiveAuctions ?? this.isShowActiveAuctions,
      isShowGoodsGridView: isShowGoodsGridView ?? this.isShowGoodsGridView,
      isShowTendersGridView:
          isShowTendersGridView ?? this.isShowTendersGridView,
      isShowAuctionsGridView:
          isShowAuctionsGridView ?? this.isShowAuctionsGridView,
      scheduleTiming: scheduleTiming ?? this.scheduleTiming,
      addCompanyModel: addCompanyModel ?? this.addCompanyModel,
      myCompanyCurrentPage: myCompanyCurrentPage ?? this.myCompanyCurrentPage,
      myCompanyPageSize: myCompanyPageSize ?? this.myCompanyPageSize,
      myCompanyLoadMore: myCompanyLoadMore ?? this.myCompanyLoadMore,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        // companyDocuments,
        myCompanies,
        isShowActiveGoods,
        isShowActiveTenders,
        isShowActiveAuctions,
        isShowGoodsGridView,
        isShowTendersGridView,
        isShowAuctionsGridView,
        scheduleTiming,
        addCompanyModel, myCompanyCurrentPage, myCompanyPageSize,
        myCompanyLoadMore,
      ];
}

// final class CompanyInitial extends CompanyState {
//   CompanyInitial() : super(addCompanyModel: AddCompanyModel());
// }

// class AddCompanyError extends CompanyState {
//   final String? error;

//   const AddCompanyError(this.error);
// }

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
