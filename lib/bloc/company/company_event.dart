part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class GetMyCompanies extends CompanyEvent {
  final int currentPage ;
  const GetMyCompanies({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

// class CompanyDetailById extends CompanyEvent {
//   final String id;
//   const CompanyDetailById(this.id);

//   @override
//   List<Object> get props => [id];
// }

class DeleteCompany extends CompanyEvent {
  final String id;
  const DeleteCompany(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateShowGood extends CompanyEvent {
  final bool showActive;
  const UpdateShowGood(this.showActive);

  @override
  List<Object> get props => [showActive];
}

class UpdateShowTenders extends CompanyEvent {
  final bool showActive;
  const UpdateShowTenders(this.showActive);

  @override
  List<Object> get props => [showActive];
}

class UpdateShowGoodsGridView extends CompanyEvent {
  final bool showGridView;
  const UpdateShowGoodsGridView(this.showGridView);

  @override
  List<Object> get props => [showGridView];
}

class UpdateShowTendersGridView extends CompanyEvent {
  final bool showGridView;
  const UpdateShowTendersGridView(this.showGridView);

  @override
  List<Object> get props => [showGridView];
}

class UpdateDay extends CompanyEvent {
  final int index;
  final bool value;
  const UpdateDay(this.index, this.value);

  @override
  List<Object> get props => [index, value];
}

class SelectCompanyLogo extends CompanyEvent {
  final ImageSource imageSource;
  const SelectCompanyLogo({required this.imageSource});
}

class SelectCompanyBanner extends CompanyEvent {}

class SelectCompanyDocument extends CompanyEvent {
  final ImageSource? imageSource;
  const SelectCompanyDocument({required this.imageSource});
}

class SelectCompanyOtherDocuments extends CompanyEvent {
  final ImageSource? imageSource;
  const SelectCompanyOtherDocuments({required this.imageSource});
}

class RemoveCompanyOtherDocument extends CompanyEvent {
  final int index;
  const RemoveCompanyOtherDocument(this.index);
}

/// add new company

class AddNewCompany extends CompanyEvent {
  final AddCompanyModel addCompanyModel;
  final BuildContext context;
  const AddNewCompany(this.addCompanyModel, this.context);

  @override
  List<Object> get props => [addCompanyModel, context];
}

class VerifyTinNumber extends CompanyEvent {
  final String tinNumber;
  const VerifyTinNumber(this.tinNumber);

  @override
  List<Object> get props => [tinNumber];
}

// update company
class UpdateCompany extends CompanyEvent {
  final AddCompanyModel addCompanyModel;
  final String companyId;
  final BuildContext context;
  const UpdateCompany({required this.addCompanyModel, required this.companyId, required this.context});

  @override
  List<Object> get props => [addCompanyModel, companyId, context];
}
