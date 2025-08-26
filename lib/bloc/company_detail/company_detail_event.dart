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

class GetCompanyInactiveProducts extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyInactiveProducts(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyTenders extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyTenders(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyInActiveTenders extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyInActiveTenders(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyAuctions extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyAuctions(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyInActiveAuctions extends CompanyDetailEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyInActiveAuctions(this.companyId, {required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
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
  List<Object> get props => [productId, context];
}

class ToggleFavoriteProductInList extends CompanyDetailEvent {
  final int productId;
  const ToggleFavoriteProductInList(this.productId);

  @override
  List<Object> get props => [productId];
}

class ToggleTenderFavorite extends CompanyDetailEvent {
  final int tenderId;
  final BuildContext context;
  const ToggleTenderFavorite(this.tenderId, this.context);

  @override
  List<Object> get props => [tenderId, context];
}

class ToggleFavoriteTenderInList extends CompanyDetailEvent {
  final int tenderId;
  const ToggleFavoriteTenderInList({required this.tenderId});

  @override
  List<Object> get props => [tenderId];
}

class ChangeProductActiveStatus extends CompanyDetailEvent {
  final String productId;
  final String updatedStatus; // e.g. 'draft' or 'published'

  const ChangeProductActiveStatus(this.productId, this.updatedStatus);

  @override
  List<Object> get props => [productId, updatedStatus];
}

class ChangeTenderActiveStatus extends CompanyDetailEvent {
  final String tenderId;
  final String updatedStatus; // e.g. 'draft' or 'published'

  const ChangeTenderActiveStatus(this.tenderId, this.updatedStatus);

  @override
  List<Object> get props => [tenderId, updatedStatus];
}
