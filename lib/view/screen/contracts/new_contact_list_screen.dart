import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/contracts/new_contract_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';

class NewContactListScreen extends StatefulWidget {
  const NewContactListScreen({super.key});

  @override
  State<NewContactListScreen> createState() => _NewContactListScreenState();
}

class _NewContactListScreenState extends State<NewContactListScreen> {
  final TextEditingController vatController = TextEditingController();
  final TextEditingController nspController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    vatController.dispose();
    nspController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'creating_a_new_contract'.tr,
                          style: h24.copyWith(color: ColorResources.darkGray),
                        ),
                        Text(
                          'please_take_a_few_minutes_to_fill_out_the_agreement_correctly'
                              .tr,
                          style: body14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'goods'.tr,
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        const SizedBox(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return productData();
                          },
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider(),
                          ),
                          itemCount: 3,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      spacing: 10,
                      children: [
                        CustomTextField1(
                          controller: vatController,
                          hintColor: '12%',
                          inputType: TextInputType.text,
                          lableText: 'НДС',
                          leading: '',
                          readOnly: false,
                        ),
                        CustomTextField1(
                          controller: nspController,
                          hintColor: '%',
                          inputType: TextInputType.text,
                          lableText: 'НсП',
                          leading: '',
                          readOnly: false,
                        ),
                        SizedBox(),
                        productItem(
                            '${"total_excluding_taxes".tr}:', '150 000 с'),
                        productItem('${"including_VAT".tr}:', '1 200 с'),
                        productItem('${"including_NSP".tr}:', '165 с'),
                        productItem('${"total_payment".tr}:', '163 000 с'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primary,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: CustomButton(
          width: Get.width,
          height: Get.height,
          onTap: () {
            Get.to(() => NewContractPaymentScreen());
          },
          title: 'continue'.tr,
        ),
      ),
    );
  }

  Widget productData() {
    return Column(
      spacing: 10,
      children: [
        productItem('Номер товара:', '1'),
        productItem('Наименование товара:', 'Стул раскладной'),
        productItem('Количество товаров(ед):', '40 шт'),
        productItem('Цена за единицу:', '3 000 сом'),
        productItem('Общая стоимость:', '50 000 сом'),
      ],
    );
  }

  Widget productItem(String title, String value) {
    return Row(
      spacing: 10,
      children: [
        Text(
          title,
          style: h16.copyWith(color: ColorResources.gray),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: body16.copyWith(color: ColorResources.titleColor),
          ),
        ),
      ],
    );
  }
}
