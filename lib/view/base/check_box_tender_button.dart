
import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tenders/tenders_bloc.dart';
import '../../bloc/tenders/tenders_state.dart';

class CheckBoxTenderButton extends StatefulWidget {
  final TenderItem? product;
  const CheckBoxTenderButton({super.key, this.product});

  @override
  State<CheckBoxTenderButton> createState() => _CheckBoxTenderButtonState();
}

class _CheckBoxTenderButtonState extends State<CheckBoxTenderButton> {
  bool checkBoxValue(List<int> selectedTender, int productId) {
    if (selectedTender.isEmpty) {
      return false;
    }
    for (int i = 0; i < selectedTender.length; i++) {
      if (selectedTender[i] == productId) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TendersBloc, TendersState>(
      builder: (context, state) {
        return Checkbox(
            value: state.selectedTender?.id == widget.product?.id,
            // checkBoxValue(state.selectedProduct.id ?? [], widget.productId!),
            onChanged: (val) {
              context
                  .read<TendersBloc>()
                  .add(ChangeSlectedTender(widget.product!));
            });
      },
    );
  }
}
