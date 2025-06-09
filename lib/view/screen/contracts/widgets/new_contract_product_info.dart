import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../data/model/response/company/company_product_model.dart';

class NewContractProductInfo extends StatefulWidget {
  final ProductListItem product;
  final int index;
  final ValueChanged<int>? onRemove;

  const NewContractProductInfo(
      {super.key,
      required this.product,
      required this.index,
      required this.onRemove});

  @override
  State<NewContractProductInfo> createState() => _NewContractProductInfoState();
}

class _NewContractProductInfoState extends State<NewContractProductInfo> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();
  final TextEditingController totalCostController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize unit price from product
    unitPriceController.text = widget.product.price?.toString() ?? '0';

    // Listen to changes in quantity or unit price
    quantityController.addListener(_calculateTotalCost);
    unitPriceController.addListener(_calculateTotalCost);
  }

  void _calculateTotalCost() {
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final unitPrice = double.tryParse(unitPriceController.text) ?? 0.0;

    final total = quantity * unitPrice;
    totalCostController.text = total.toStringAsFixed(2);
  }

  @override
  void dispose() {
    quantityController.dispose();
    unitPriceController.dispose();
    totalCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'product_name'.tr,
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorResources.lightBlue,
              border: Border.all(
                width: 1,
                color: ColorResources.lgColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              spacing: 10,
              children: [
                CustomImage(
                    image: widget.product.image ?? '',
                    height: 40,
                    width: 40,
                    radius: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name ?? '',
                      // 'Стул раскладной',
                      style: h16.copyWith(color: ColorResources.darkGray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.description ?? '',
                      // 'Стулья из натурального дерева',
                      style: body14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextField1(
                  controller: quantityController,
                  hintColor: 'product_quantity'.tr,
                  inputType: TextInputType.number,
                  lableText: 'product_quantity'.tr,
                  leading: '',
                  readOnly: false,
                  lableStyle: h16.copyWith(
                    color: ColorResources.darkGray,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              unitBox('Ед.изм', 'шт'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextField1(
                  controller: unitPriceController,
                  hintColor: '',
                  inputType: TextInputType.number,
                  lableText: 'unit_price'.tr,
                  leading: '',
                  readOnly: false,
                  lableStyle: h16.copyWith(
                    color: ColorResources.darkGray,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              unitBox('currency', 'KGS'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextField1(
                  controller: totalCostController,
                  hintColor: '',
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  lableText: 'total_cost'.tr,
                  leading: '',
                  readOnly: false,
                  lableStyle: h16.copyWith(
                    color: ColorResources.darkGray,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*'),
                    ),
                  ],
                ),
              ),
              unitBox('currency', 'KGS'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (widget.index != 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      CustomDialog(
                        widget: AlertDialog(
                          backgroundColor: Colors.white,
                          content: Column(
                            spacing: 20,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SvgPicture.asset(
                                  //   // Images.svgBoxIcon1,
                                  //   Images.svgHelpCircle,
                                  //   color: ColorResources.red,
                                  // ),
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromRGBO(253, 162, 155, 0.5),
                                        shape: BoxShape.circle),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      Images.svgHelpCircle,
                                      color: ColorResources.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              Text(
                                'delete_a_product'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      width: Get.width,
                                      height: 45,
                                      onTap: () {
                                        Get.back();
                                      },
                                      title: 'cancel'.tr,
                                      color: ColorResources.lgColor,
                                      textColor: ColorResources.gray,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      width: Get.width,
                                      height: 45,
                                      onTap: () {
                                        Get.back();
                                        widget.onRemove?.call(widget.index);
                                      },
                                      title: 'delete'.tr,
                                      color: ColorResources.red,
                                      textColor: ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'remove_product'.tr,
                    style: button16.copyWith(color: ColorResources.red),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget unitBox(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title.tr,
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
        Container(
          height: 48,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: ColorResources.green),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: body14,
          ),
        ),
      ],
    );
  }
}
