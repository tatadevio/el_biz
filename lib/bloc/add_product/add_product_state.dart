part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  final AddProductModel? productData;
  const AddProductState({this.productData});

  AddProductState copyWith({AddProductModel? productData}) {
    return AddProductState(productData: productData ?? this.productData);
  }

  @override
  List<Object> get props => [
        productData!,
      ];
}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductLoaded extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final String? message;
  final ProductListItem? productItem;
  const AddProductSuccess(this.message, this.productItem);
}

final class AddProductFailure extends AddProductState {
  final String message;
  const AddProductFailure(this.message);
}
