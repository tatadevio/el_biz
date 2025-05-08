import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/response/category/categories_list_model.dart';
import '../../data/model/response/company/my_companies_model.dart';
import '../../data/model/response/tender/tender_detail_model.dart';

abstract class TendersEvent extends Equatable {
  const TendersEvent();

  @override
  List<Object> get props => [];
}

class UpdateGridView extends TendersEvent {
  final bool isGridView;

  const UpdateGridView(this.isGridView);

  @override
  List<Object> get props => [isGridView];
}

class FetchAllTenders extends TendersEvent {}

class PickImageDocs extends TendersEvent {}

class PickImageDocsCamera extends TendersEvent {}

class RemoveGallery extends TendersEvent {
  final XFile image;
  const RemoveGallery(this.image);

  @override
  List<Object> get props => [image];
}

class ResetNewTenderModel extends TendersEvent {}




class UpdateTenderImages extends TendersEvent {
  final List<Media> images;
  const UpdateTenderImages(this.images);

  @override
  List<Object> get props => [images];
}

class RemoveTenderImage extends TendersEvent {
  final Media tenderImage;
  const RemoveTenderImage(this.tenderImage);

  @override
  List<Object> get props => [tenderImage];
}

class GetCategoryById extends TendersEvent {
  final String categoryId;
  const GetCategoryById(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class SelectCategory extends TendersEvent {
  final CategoryItem category;
  const SelectCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateTenderCompany extends TendersEvent {
  final CompanyItem company;
  const UpdateTenderCompany({required this.company});

  @override
  List<Object> get props => [company];
}


