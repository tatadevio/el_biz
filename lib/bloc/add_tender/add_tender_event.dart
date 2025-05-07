part of 'add_tender_bloc.dart';

sealed class AddTenderEvent extends Equatable {
  const AddTenderEvent();

  @override
  List<Object> get props => [];
}

class AddNewTender extends AddTenderEvent {
  final AddTenderModel addTenderModel;
  const AddNewTender({required this.addTenderModel});

  @override
  List<Object> get props => [addTenderModel];
}

class UpdateTenderImages extends AddTenderEvent {
  final List<Media> images;
  const UpdateTenderImages(this.images);

  @override
  List<Object> get props => [images];
}

class RemoveTenderImage extends AddTenderEvent {
  final Media tenderImage;
  const RemoveTenderImage(this.tenderImage);

  @override
  List<Object> get props => [tenderImage];
}

class GetCategoryById extends AddTenderEvent {
  final String categoryId;
  const GetCategoryById(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SelectCategory extends AddTenderEvent {
  final CategoryItem category;
  const SelectCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateTenderCompany extends AddTenderEvent {
  final CompanyItem company;
  const UpdateTenderCompany({required this.company});

  @override
  List<Object> get props => [company];
}
