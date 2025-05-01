import 'package:bloc/bloc.dart';
import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/data/repo/add_product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/model/base/add_product_model.dart';
import '../../data/model/response/materials_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductRepo addProductRepo;
  AddProductBloc(this.addProductRepo)
      : super(AddProductState(productData: AddProductModel())) {
    // on<AddProductEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<AddProduct>(_onAddProduct);
    on<SelectCategory>(_onSelectCategory);
    on<SelectMaterial>(_onSelectMaterial);
  }

  Future<void> _onSelectCategory(
      SelectCategory event, Emitter<AddProductState> emit) async {
    emit(state.copyWith(
        productData: state.productData?.copyWith(category: event.category)));
  }

  Future<void> _onSelectMaterial(
      SelectMaterial event, Emitter<AddProductState> emit) async {
    emit(state.copyWith(
        productData:
            state.productData?.copyWith(material: event.materialItem)));
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<AddProductState> emit) async {
    emit(AddProductLoading());
    emit(AddProductState(productData: event.addProductModel));
    try {
      Response response =
          await addProductRepo.addNewProduct(event.addProductModel);
      if (response.statusCode == 200) {
        emit(AddProductSuccess());
        emit(state.copyWith(productData: AddProductModel()));
      } else {
        emit(AddProductFailure(response.body));
      }
    } catch (e) {
      // emit(AddProductState(productData: event.addProductModel, error: e.toString()));
    }
  }
}
