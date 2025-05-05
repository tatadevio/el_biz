part of 'company_detail_bloc.dart';

sealed class CompanyDetailEvent extends Equatable {
  const CompanyDetailEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyDetail extends CompanyDetailEvent {
  final String companyId;
  const GetCompanyDetail(this.companyId);

  @override
  List<Object> get props => [companyId];
}

class GetCompanyProducts extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyProducts(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyTenders extends CompanyDetailEvent {
  final String companyId;
  const GetCompanyTenders(this.companyId);

  @override
  List<Object> get props => [companyId];
}

class GetCompanyReviews extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyReviews(this.companyId, this.currentPage);

  @override
  List<Object> get props => [companyId, currentPage];
}

class AddCompanyReviewReply extends CompanyDetailEvent {
  final String reviewId;
  final String reply;
  final int index;
  const AddCompanyReviewReply(this.reviewId, this.reply, this.index);

  @override
  List<Object> get props => [reviewId, reply, index];
}

class DeleteCompanyReview extends CompanyDetailEvent {
  final String reviewId;
  const DeleteCompanyReview(this.reviewId);

  @override
  List<Object> get props => [reviewId];
}

class GetCompanyDocuments extends CompanyDetailEvent {
  final String companyId;
  const GetCompanyDocuments(this.companyId);

  @override
  List<Object> get props => [companyId];
}

class DeleteCompanyDocument extends CompanyDetailEvent {
  final String documentId;
  const DeleteCompanyDocument(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class ToggleFavoriteProduct extends CompanyDetailEvent {
  final int productId;
  final BuildContext context;
  const ToggleFavoriteProduct(this.productId, this.context);

  @override
  List<Object> get props => [productId];
}

class ToggleFavoriteProductInList extends CompanyDetailEvent {
  final int productId;
  const ToggleFavoriteProductInList(this.productId);

  @override
  List<Object> get props => [productId];
}
