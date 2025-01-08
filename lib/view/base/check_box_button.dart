import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';

class CheckBoxButton extends StatefulWidget {
  final int? productId;
  const CheckBoxButton({super.key, this.productId});

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
            value:
                checkBoxValue(state.selectedProductId ?? [], widget.productId!),
            onChanged: (val) {
              context
                  .read<ProductBloc>()
                  .add(ChangeSlectedProduct(widget.productId!));
            });
      },
    );
  }
}
