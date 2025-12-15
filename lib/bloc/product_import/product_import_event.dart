import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class ProductImportEvent extends Equatable {
  const ProductImportEvent();

  @override
  List<Object?> get props => [];
}

class ProductImportRequested extends ProductImportEvent {
  const ProductImportRequested();

  @override
  List<Object?> get props => [];
}

class ProductImportReset extends ProductImportEvent {}

class AddImportProducts extends ProductImportEvent {
  final FilePickerResult file;
  final String categoryId;
  final String companyId;

  const AddImportProducts(
      {required this.file, required this.categoryId, required this.companyId});

  @override
  List<Object?> get props => [file, categoryId, companyId];
}
