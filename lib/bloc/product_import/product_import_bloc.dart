import 'dart:developer';

import 'package:el_biz/data/model/response/product/import_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/product_import_repo.dart';
import 'product_import_event.dart';
import 'product_import_state.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ProductImportBloc extends Bloc<ProductImportEvent, ProductImportState> {
  final ProductImportRepo repository;

  ProductImportBloc({required this.repository})
      : super(ProductImportInitial()) {
    on<ProductImportRequested>(_onRequested);
    on<ProductImportReset>((event, emit) => emit(ProductImportInitial()));
    on<AddImportProducts>(_addImportProducts);
  }

  Future<void> _onRequested(
      ProductImportRequested event, Emitter<ProductImportState> emit) async {
    emit(ProductImportLoading());
    try {
      final Response res = await repository.importProductTemplate();

// You can adjust success criteria depending on your API behaviour
      final statusCode = res.statusCode ?? 0;
      if (statusCode >= 200 && statusCode < 300) {
        log('this is the status code ${statusCode} and respose = ${res.body}');
        emit(ProductImportSuccess(res));
      } else {
        final message = _extractMessage(res) ?? 'Failed to import template';
        emit(ProductImportFailure(message));
      }
    } catch (e) {
// Log if you have a logger
      emit(ProductImportFailure(e.toString()));
    }
  }

  String? _extractMessage(Response res) {
    try {
// Typical GetConnect Response has `body` that can be JSON or string.
      final body = res.body;
      if (body == null) return null;
      if (body is Map && body['message'] != null)
        return body['message'].toString();
      return body.toString();
    } catch (e) {
      return null;
    }
  }

  Future<void> _addImportProducts(
      AddImportProducts event, Emitter<ProductImportState> emit) async {
    emit(ProductImportLoading());
    // try {
    final response = await repository.addImportProducts(
        event.file, event.categoryId, event.companyId);
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      final importedResponse = ImportProductsModel.fromJson(response.body);
      log('data in the bloc file = ${importedResponse.toJson()}');
      emit(state.copyWith(importProductsModel: importedResponse));

      log('data in the state file = ${state.importProductsModel?.toJson()}');
      emit(AddImportProductsSuccess());
    } else {
      emit(AddImportProductsError(error: response.body['message'] ?? ''));
    }
    // } catch (e) {
    //   emit(AddImportProductsError(error: e.toString()));
    // }
  }
}
