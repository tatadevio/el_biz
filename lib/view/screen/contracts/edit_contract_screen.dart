import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/model/base/selected_product_info.dart';
import 'package:el_biz/data/model/response/agreement/company_sales_model.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/contracts/new_contact_list_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/edit_contract_product_info.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/select_tender/select_company_product.dart';
import 'package:el_biz/view/screen/select_tender/select_company_tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/product/product_bloc.dart';

class EditContractScreen extends StatefulWidget {
  final CompanyContractItem contractModel;

  const EditContractScreen({
    super.key,
    required this.contractModel,
  });

  @override
  State<EditContractScreen> createState() => _EditContractScreenState();
}

class _EditContractScreenState extends State<EditContractScreen> {
  List<SelectedProductInfo> selectedProductInfoList = [];
  final TextEditingController contractNameController = TextEditingController();

  @override
  initState() {
    super.initState();

    // Initialize contract name
    contractNameController.text = widget.contractModel.contractName ?? '';

    // Convert contract products to SelectedProductInfo
    if (widget.contractModel.contractProducts != null) {
      for (var contractProduct in widget.contractModel.contractProducts!) {
        // Create ProductListItem from ContractProduct
        ProductListItem product = ProductListItem(
          id: contractProduct.productId,
          name: contractProduct.productName,
          quantity: contractProduct.quantity?.toString(),
          price: int.tryParse(contractProduct.unitPrice ?? '0'),
        );

        // Create TenderItem (empty for now, since we don't have tender data in contract)
        TenderItem tenderItem = TenderItem();

        selectedProductInfoList.add(SelectedProductInfo(
          product: product,
          tenderItem: tenderItem,
          totalQuantity: contractProduct.quantity ?? 0,
          unitPrice: int.tryParse(contractProduct.unitPrice ?? '0') ?? 0,
          subtotal: int.tryParse(contractProduct.totalAmount ?? '0') ?? 0,
        ));
      }
    }

    // Load company data based on contract type
    if (widget.contractModel.contractType == 'tender') {
      context.read<CompanyDetailBloc>().add(GetCompanyTenders(
          widget.contractModel.sellerId.toString(),
          currentPage: 1));
    } else {
      context.read<CompanyDetailBloc>().add(GetCompanyProducts(
          widget.contractModel.sellerId.toString(),
          currentPage: 1));
    }
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
                'edit_contract'.tr,
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
                hintColor: 'contract_name'.tr,
                inputType: TextInputType.text,
                lableText: 'contract_name'.tr,
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
              ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedProductInfoList.length,
                  itemBuilder: (context, index) {
                    return EditContractProductInfo(
                      product: selectedProductInfoList[index],
                      index: index,
                      type: widget.contractModel.contractType ?? 'product',
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
                    title: widget.contractModel.contractType == 'tender'
                        ? 'add_tender'.tr
                        : 'add_products'.tr,
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
                                onTap: widget.contractModel.contractType ==
                                        'tender'
                                    ? () {
                                        context
                                            .read<TendersBloc>()
                                            .add(ClearSelectedTender());

                                        List<int> tenderIds =
                                            selectedProductInfoList
                                                .map(
                                                    (e) => e.tenderItem.id ?? 0)
                                                .toList();
                                        Get.back();
                                        Get.to(() => SelectCompanyTenderScreen(
                                              alreadySelectedItems: tenderIds,
                                              onSelect: (val) async {
                                                Get.back();

                                                if (val != null) {
                                                  setState(() {
                                                    selectedProductInfoList.add(
                                                        SelectedProductInfo(
                                                            product:
                                                                ProductListItem(),
                                                            tenderItem: val,
                                                            totalQuantity:
                                                                int.tryParse(val
                                                                            .quantity ??
                                                                        '0') ??
                                                                    0,
                                                            unitPrice:
                                                                val.budgetFrom ??
                                                                    0,
                                                            subtotal: int.parse(
                                                                    val.quantity!) *
                                                                val.budgetFrom!));
                                                  });
                                                }
                                              },
                                            ));
                                      }
                                    : () {
                                        context
                                            .read<ProductBloc>()
                                            .add(ClearSelectedProduct());
                                        List<int> selectedProducts =
                                            selectedProductInfoList
                                                .map((e) => e.product.id ?? 0)
                                                .toList();
                                        Get.back();
                                        Get.to(() => SelectCompanyProduct(
                                              isSelectProduct: true,
                                              selectedProducts:
                                                  selectedProducts,
                                              onSendProduct: () async {
                                                Get.back();

                                                // Get the selected product from Bloc (you can change this based on your logic)
                                                ProductListItem?
                                                    selectedProduct = context
                                                        .read<ProductBloc>()
                                                        .state
                                                        .selectedProduct;

                                                if (selectedProduct != null) {
                                                  setState(() {
                                                    selectedProductInfoList.add(SelectedProductInfo(
                                                        product:
                                                            selectedProduct,
                                                        tenderItem:
                                                            TenderItem(),
                                                        totalQuantity: int.tryParse(
                                                                selectedProduct
                                                                        .quantity ??
                                                                    '0') ??
                                                            0,
                                                        unitPrice:
                                                            selectedProduct
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
                                      },
                                title: 'add_manually'.tr,
                                color: ColorResources.blue,
                                textColor: ColorResources.white,
                              ),
                              CustomButton(
                                width: Get.width,
                                height: 48,
                                onTap: widget.contractModel.contractType ==
                                        'tender'
                                    ? () {
                                        context
                                            .read<TendersBloc>()
                                            .add(ClearSelectedTender());

                                        List<int> tenderIds =
                                            selectedProductInfoList
                                                .map(
                                                    (e) => e.tenderItem.id ?? 0)
                                                .toList();
                                        Get.back();
                                        Get.to(() => SelectCompanyTenderScreen(
                                              alreadySelectedItems: tenderIds,
                                              onSelect: (val) async {
                                                Get.back();

                                                if (val != null) {
                                                  setState(() {
                                                    selectedProductInfoList.add(
                                                        SelectedProductInfo(
                                                            product:
                                                                ProductListItem(),
                                                            tenderItem: val,
                                                            totalQuantity:
                                                                int.tryParse(val
                                                                            .quantity ??
                                                                        '0') ??
                                                                    0,
                                                            unitPrice:
                                                                val.budgetFrom ??
                                                                    0,
                                                            subtotal: int.parse(
                                                                    val.quantity!) *
                                                                val.budgetFrom!));
                                                  });
                                                }
                                              },
                                            ));
                                      }
                                    : () {
                                        context
                                            .read<ProductBloc>()
                                            .add(ClearSelectedProduct());
                                        List<int> selectedProducts =
                                            selectedProductInfoList
                                                .map((e) => e.product.id ?? 0)
                                                .toList();
                                        Get.back();
                                        Get.to(() => SelectCompanyProduct(
                                              isSelectProduct: true,
                                              selectedProducts:
                                                  selectedProducts,
                                              onSendProduct: () async {
                                                Get.back();

                                                // Get the selected product from Bloc (you can change this based on your logic)
                                                ProductListItem?
                                                    selectedProduct = context
                                                        .read<ProductBloc>()
                                                        .state
                                                        .selectedProduct;

                                                if (selectedProduct != null) {
                                                  setState(() {
                                                    selectedProductInfoList.add(SelectedProductInfo(
                                                        product:
                                                            selectedProduct,
                                                        tenderItem:
                                                            TenderItem(),
                                                        totalQuantity: int.tryParse(
                                                                selectedProduct
                                                                        .quantity ??
                                                                    '0') ??
                                                            0,
                                                        unitPrice:
                                                            selectedProduct
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
                    showShortToast('add_contract_name'.tr);
                  }
                : () {
                    // Navigate to contact list screen with updated data
                    Get.to(() => NewContactListScreen(
                          selectedProductsList: selectedProductInfoList,
                          buyerId: widget.contractModel.buyerId.toString(),
                          type: widget.contractModel.contractType ?? 'product',
                          productId:
                              widget.contractModel.contractType == 'tender'
                                  ? '0'
                                  : widget.contractModel.productId.toString(),
                          tenderId:
                              widget.contractModel.contractType == 'tender'
                                  ? widget.contractModel.tenderId.toString()
                                  : '0',
                          contractName: contractNameController.text.trim(),
                          companyId: widget.contractModel.sellerId ?? 0,
                          isEditing:
                              true, // Add this flag to indicate editing mode
                          contractId: widget.contractModel
                              .id, // Pass the contract ID for updating
                        ));
                  },
            title: 'save_changes'.tr),
      ),
    );
  }
}
