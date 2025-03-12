part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
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

class SelectCompanyLogo extends CompanyEvent {}

class SelectCompanyBanner extends CompanyEvent {}
