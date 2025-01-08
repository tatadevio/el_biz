import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/screen/contracts/new_contact_list_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/new_contract_product_info.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NewContractScreen extends StatelessWidget {
  const NewContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              const SizedBox(height: 10),
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
              Text(
                'goods'.tr,
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const NewContractProductInfo(),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtonWithIcon(
                    title: 'add_products'.tr,
                    svgIcon: Images.svgPlus,
                    buttonColor: ColorResources.lgColor,
                    borderColor: ColorResources.lgColor,
                    svgIconColor: ColorResources.gray,
                    textColor: ColorResources.gray,
                    isMaxSize: false,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            children: [
                              Row(
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
                              Text(
                                'select_how_to_add'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              CustomButton(
                                width: Get.width,
                                height: 48,
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const ProductScreen(
                                        isSelectProduct: true,
                                      ));
                                },
                                title: 'add_manually'.tr,
                                color: ColorResources.blue,
                                textColor: ColorResources.white,
                              ),
                              CustomButton(
                                width: Get.width,
                                height: 48,
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const ProductScreen(
                                        isSelectProduct: true,
                                      ));
                                },
                                title: 'select_from_the_catalog'.tr,
                                color: ColorResources.lgColor,
                                textColor: ColorResources.gray,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              // Get.back();
              Get.to(() => NewContactListScreen());
            },
            title: 'continue'.tr),
      ),
    );
  }
}
