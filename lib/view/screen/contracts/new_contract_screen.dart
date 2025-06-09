import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/screen/contracts/new_contact_list_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/new_contract_product_info.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/product/product_bloc.dart';

class NewContractScreen extends StatefulWidget {
  final ProductListItem product;

  const NewContractScreen({super.key, required this.product});

  @override
  State<NewContractScreen> createState() => _NewContractScreenState();
}

class _NewContractScreenState extends State<NewContractScreen> {
  List<ProductListItem> selectedProducts = [];

  @override
  initState() {
    super.initState();
    // Initialize the selected products list with the product passed to this screen.
    selectedProducts.add(widget.product);
  }

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
              // Column(
              //   children: selectedProducts
              //       .map((product) => NewContractProductInfo(product: product))
              //       .toList(),
              // ),
              ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedProducts.length,
                  itemBuilder: (context, index) {
                    return NewContractProductInfo(
                      product: selectedProducts[index],
                      index: index,
                      onRemove: (int productIndex) {
                        setState(() {
                          selectedProducts.removeAt(productIndex);
                        });
                      },
                    );
                  }),
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
                                  Get.to(() => ProductScreen(
                                        isSelectProduct: true,
                                        onSendProduct: () async {
                                          Get.back();

                                          // Get the selected product from Bloc (you can change this based on your logic)
                                          ProductListItem? selectedProduct =
                                              context
                                                  .read<ProductBloc>()
                                                  .state
                                                  .selectedProduct;

                                          if (selectedProduct != null) {
                                            setState(() {
                                              selectedProducts
                                                  .add(selectedProduct);
                                            });
                                          }
                                        },
                                      ));

                                  // Get.to(() => ProductScreen(
                                  //       isSelectProduct: true,
                                  //       onSendProduct: () async {
                                  //         Get.back();
                                  //         ProductListItem? selectedProduct =
                                  //             context
                                  //                 .read<ProductBloc>()
                                  //                 .state
                                  //                 .selectedProduct;
                                  //       },
                                  //     ));
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
                                  Get.to(() => ProductScreen(
                                        isSelectProduct: true,
                                        onSendProduct: () async {
                                          Get.back();

                                          ProductListItem? selectedProduct =
                                              context
                                                  .read<ProductBloc>()
                                                  .state
                                                  .selectedProduct;

                                          if (selectedProduct != null) {
                                            setState(() {
                                              selectedProducts
                                                  .add(selectedProduct);
                                            });
                                          }
                                        },
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
