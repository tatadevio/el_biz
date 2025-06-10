import 'package:el_biz/data/model/base/selected_product_info.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/contracts/new_contact_list_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/new_contract_product_info.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/product/product_bloc.dart';

class NewContractScreen extends StatefulWidget {
  final ProductListItem product;
  final String buyerId;
  final String type;
  final String productId;
  final String tenderId;

  const NewContractScreen({
    super.key,
    required this.product,
    required this.buyerId,
    required this.type,
    required this.productId,
    required this.tenderId,
  });
  // const NewContractScreen({super.key, required this.product, required this.buyerId});

  @override
  State<NewContractScreen> createState() => _NewContractScreenState();
}

class _NewContractScreenState extends State<NewContractScreen> {
  List<SelectedProductInfo> selectedProductInfoList = [];
  final TextEditingController contractNameController = TextEditingController();

  @override
  initState() {
    super.initState();

    selectedProductInfoList.add(SelectedProductInfo(
        product: widget.product,
        totalQuantity: int.tryParse(widget.product.quantity ?? '0') ?? 0,
        unitPrice: int.parse(widget.product.price.toString()),
        subtotal: int.parse(widget.product.price.toString()) *
            (int.tryParse(widget.product.quantity ?? '0') ?? 0)));
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
              CustomTextField1(
                controller: contractNameController,
                hintColor: 'tender_name'.tr,
                inputType: TextInputType.text,
                lableText: 'tender_name'.tr,
                leading: '',
                readOnly: false,
                onChanged: (p0) {
                  setState(() {});
                },
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
                  itemCount: selectedProductInfoList.length,
                  itemBuilder: (context, index) {
                    return NewContractProductInfo(
                      product: selectedProductInfoList[index],
                      index: index,
                      onRemove: (int productIndex) {
                        setState(() {
                          selectedProductInfoList.removeAt(productIndex);
                        });
                      },
                      onUpdate: (val) {
                        setState(() {
                          selectedProductInfoList[val.index] = val.info;
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
                                              selectedProductInfoList.add(
                                                  SelectedProductInfo(
                                                      product: selectedProduct,
                                                      totalQuantity: int.tryParse(
                                                              selectedProduct
                                                                      .quantity ??
                                                                  '0') ??
                                                          0,
                                                      unitPrice: selectedProduct
                                                              .price ??
                                                          0,
                                                      subtotal: int.parse(
                                                              selectedProduct
                                                                  .quantity!) *
                                                          selectedProduct
                                                              .price!));
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
                                              selectedProductInfoList.add(
                                                  SelectedProductInfo(
                                                      product: selectedProduct,
                                                      totalQuantity: int.tryParse(
                                                              selectedProduct
                                                                      .quantity ??
                                                                  '0') ??
                                                          0,
                                                      unitPrice: selectedProduct
                                                              .price ??
                                                          0,
                                                      subtotal: int.parse(
                                                              selectedProduct
                                                                  .quantity!) *
                                                          selectedProduct
                                                              .price!));
                                              // selectedProducts
                                              //     .add(selectedProduct);
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
            onTap: contractNameController.text.trim().isEmpty
                ? () {
                    showShortToast('add_tender_name'.tr);
                  }
                : () {
                    // Get.back();
                    Get.to(() => NewContactListScreen(
                          selectedProductsList: selectedProductInfoList,
                          buyerId: widget.buyerId,
                          type: widget.type,
                          productId: widget.productId,
                          tenderId: widget.tenderId,
                          contractName: contractNameController.text.trim(),
                        ));
                  },
            title: 'continue'.tr),
      ),
    );
  }
}
