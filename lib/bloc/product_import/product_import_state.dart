import 'package:el_biz/data/model/response/product/import_product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductImportState extends Equatable {
  final ImportProductsModel? importProductsModel;
  const ProductImportState({this.importProductsModel});

  ProductImportState copyWith({ImportProductsModel? importProductsModel}) {
    return ProductImportState(
        importProductsModel: importProductsModel ?? this.importProductsModel);
  }

  @override
  List<Object?> get props => [importProductsModel];
}

class ProductImportInitial extends ProductImportState {}

class ProductImportLoading extends ProductImportState {}

class ProductImportSuccess extends ProductImportState {
  final Response response;

  const ProductImportSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ProductImportFailure extends ProductImportState {
  final String message;

  const ProductImportFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AddImportProductsSuccess extends ProductImportState {}

class AddImportProductsError extends ProductImportState {
  final String error;
  const AddImportProductsError({required this.error});

  @override
  List<Object?> get props => [error];
}
