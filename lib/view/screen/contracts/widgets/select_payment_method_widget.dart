import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/data/model/response/agreement/payment_methods_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class SelectPaymentMethodWidget extends StatefulWidget {
  final ValueChanged<PaymentMethod> paymentMethod;
  const SelectPaymentMethodWidget({super.key, required this.paymentMethod});

  @override
  State<SelectPaymentMethodWidget> createState() =>
      _SelectPaymentMethodWidgetState();
}

class _SelectPaymentMethodWidgetState extends State<SelectPaymentMethodWidget> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _selectedOption = updateSelecteOption();
      });
    });
  }

  String updateSelecteOption() {
    PaymentMethod? paymentMethod;
    for (var method in context.read<AgreementBloc>().state.paymentMethods) {
      if (method.isDefault == true) {
        paymentMethod = method;
      }
    }
    if (context.read<AgreementBloc>().state.paymentMethods.isEmpty) {
      return '';
    }

    if (paymentMethod == null) {
      final selectedMethod =
          context.read<AgreementBloc>().state.paymentMethods[0];
      widget.paymentMethod(selectedMethod);
      return selectedMethod.id.toString();
    } else {
      widget.paymentMethod(paymentMethod);
      return paymentMethod.id.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgreementBloc, AgreementState>(
        builder: (context, agreementState) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: agreementState.paymentMethods.length,
        itemBuilder: (context, index) {
          return accoutItem(agreementState.paymentMethods[index]
              // 'cash', 'payment_is_made_in_cash_between_the_parties',

              );
        },
        // children: [
        //   accoutItem('cashless_payment',
        //       'cashless_payment_based_on_the_details_linked_to_your_account'),

        // ],
      );
    });
  }

  Widget accoutItem(PaymentMethod payment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            RadioListTile<String>(
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment.name ?? '',
                    // title.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(33, 32, 32, 1)),
                  ),
                  Text(
                    payment.description ?? '',
                    // subTitle.tr,
                    style: body16.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
              value: payment.id.toString(),
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });

                PaymentMethod? paymentMethod =
                    selectPaymentMethodFromId(_selectedOption);
                if (paymentMethod != null) {
                  widget.paymentMethod(paymentMethod);
                }
                print(
                    'this is the value of the selected options == ${_selectedOption}');
              },
            ),
          ],
        ),
      ),
    );
  }

  PaymentMethod? selectPaymentMethodFromId(String id) {
    int index = -1;
    index = context
        .read<AgreementBloc>()
        .state
        .paymentMethods
        .indexWhere((agreement) => agreement.id.toString() == id);

    if (index != -1) {
      PaymentMethod selectedPaymentMethod =
          context.read<AgreementBloc>().state.paymentMethods[index];
      return selectedPaymentMethod;
    }
    return null;
  }
}
