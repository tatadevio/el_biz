import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/screen/company/add_company_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class SelectCurrencyWidget extends StatefulWidget {
  final bool isEdit;
  const SelectCurrencyWidget({super.key, required this.isEdit});

  @override
  State<SelectCurrencyWidget> createState() => _SelectCurrencyWidgetState();
}

class _SelectCurrencyWidgetState extends State<SelectCurrencyWidget> {
  String selectedCurrency = 'KGS';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    color: ColorResources.lgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'select_main_account'.tr,
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioListTile<String>(
            title: Text('Optima KGS'),
            value: 'KGS',
            groupValue: selectedCurrency,
            onChanged: (value) {
              setState(() {
                selectedCurrency = value!;
              });
            },
          ),
          const Divider(),
          RadioListTile<String>(
            title: Text('Optima USD'),
            value: 'USD',
            groupValue: selectedCurrency,
            onChanged: (value) {
              setState(() {
                selectedCurrency = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              Get.back();
              Get.to(() => AddCompanyDocumentScreen(
                isEdit: widget.isEdit,
              ));
            },
            title: 'ready'.tr,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
