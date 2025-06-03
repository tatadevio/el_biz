import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';

class CheckBoxButton extends StatefulWidget {
  final ProductListItem? product;
  const CheckBoxButton({super.key, this.product});

  @override
  State<CheckBoxButton> createState() => _CheckBoxButtonState();
}

class _CheckBoxButtonState extends State<CheckBoxButton> {
  bool checkBoxValue(List<int> selectedProductId, int productId) {
    if (selectedProductId.isEmpty) {
      return false;
    }
    for (int i = 0; i < selectedProductId.length; i++) {
      if (selectedProductId[i] == productId) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Checkbox(
            value: state.selectedProduct?.id == widget.product?.id,
                // checkBoxValue(state.selectedProduct.id ?? [], widget.productId!),
            onChanged: (val) {
              context
                  .read<ProductBloc>()
                  .add(ChangeSlectedProduct(widget.product!));
            });
      },
    );
  }
}
