import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/add_product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/model/base/add_product_model.dart';

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
      } else {
        emit(AddProductFailure(response.body));
      }
    } catch (e) {
      // emit(AddProductState(productData: event.addProductModel, error: e.toString()));
    }
  }
}
