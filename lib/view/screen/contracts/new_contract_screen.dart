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
import 'package:el_biz/view/screen/contracts/widgets/new_contract_product_info.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/select_tender/select_company_product.dart';
import 'package:el_biz/view/screen/select_tender/select_company_tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/product/product_bloc.dart';

class NewContractScreen extends StatefulWidget {
  final ProductListItem product;
  final TenderItem tenderItem;
  final String buyerId;
  final String type;
  final CompanyContractItem? contractModel;
  final bool isEditing;
  // final String productId;
  // final String tenderId;
  final int companyId;

  const NewContractScreen({
    super.key,
    required this.product,
    required this.tenderItem,
    required this.buyerId,
    required this.type,
    // required this.productId,
    // required this.tenderId,
    required this.companyId,
    this.contractModel,
    this.isEditing = false,
  });
  // const NewContractScreen({super.key, required this.product, required this.buyerId});

  @override
  State<NewContractScreen> createState() => _NewContractScreenState();
}

class _NewContractScreenState extends State<NewContractScreen> {
  List<SelectedProductInfo> selectedProductInfoList = [];
  // List<TenderItem> selectedTenderInfoList = [];
  final TextEditingController contractNameController = TextEditingController();

  @override
  initState() {
    super.initState();

    if (widget.isEditing) {
      if (widget.type == 'tender') {
        for (var contractProduct in widget.contractModel!.contractProducts!) {
          // selectedProductInfoList.add(SelectedProductInfo(
          //     product: ProductListItem(),
          //     tenderItem: TenderItem(
          //       id: contractProduct.id,
          //       title: contractProduct.productName,
          //       quantity: contractProduct.quantity.toString(),
          //       budgetFrom: int.tryParse(contractProduct.unitPrice ?? '0'),
          //       budgetTo: int.tryParse(contractProduct.unitPrice ?? '0'),
          //       // budgetType: 'tender',
          //       // budgetUnit: 'tender',
          //       image: "",
          //     ),
          //     totalQuantity:
          //         int.tryParse(contractProduct.quantity ?? '0') ?? 0,
          //     unitPrice: int.parse(contractProduct.budgetFrom.toString()),
          //     subtotal: int.parse(widget.tenderItem.budgetFrom.toString()) *
          //         (int.tryParse(widget.tenderItem.quantity ?? '0') ?? 0)));
        }

        context.read<CompanyDetailBloc>().add(
            GetCompanyTenders(widget.companyId.toString(), currentPage: 1));
      } else {
        for (var contractProduct in widget.contractModel!.contractProducts!) {
          int unitPrice =
              double.parse(contractProduct.unitPrice ?? '0').toInt();
          int quantity = contractProduct.quantity ?? 0;

          ProductListItem product = ProductListItem(
            id: contractProduct.productId,
            name: contractProduct.productName,
            price: unitPrice,
            quantity: quantity.toString(),
            image: "",
          );

          selectedProductInfoList.add(SelectedProductInfo(
              product: product,
              tenderItem: TenderItem(),
              totalQuantity: contractProduct.quantity ?? 0,
              unitPrice: unitPrice,
              subtotal: unitPrice * quantity));

          // print("UNIT PRICE 2 ${unitPrice}");
          context.read<ProductBloc>().add(ChangeSlectedProduct(product));
        }

        context.read<CompanyDetailBloc>().add(
            GetCompanyProducts(widget.companyId.toString(), currentPage: 1));
      }
    } else {
      if (widget.type == 'tender') {
        selectedProductInfoList.add(SelectedProductInfo(
            product: ProductListItem(),
            tenderItem: widget.tenderItem,
            totalQuantity: int.tryParse(widget.tenderItem.quantity ?? '0') ?? 0,
            unitPrice: int.parse(widget.tenderItem.budgetFrom.toString()),
            subtotal: int.parse(widget.tenderItem.budgetFrom.toString()) *
                (int.tryParse(widget.tenderItem.quantity ?? '0') ?? 0)));

        context.read<CompanyDetailBloc>().add(
            GetCompanyTenders(widget.companyId.toString(), currentPage: 1));
      } else {
        selectedProductInfoList.add(SelectedProductInfo(
            product: widget.product,
            tenderItem: TenderItem(),
            totalQuantity: int.tryParse(widget.product.quantity ?? '0') ?? 0,
            unitPrice: int.parse(widget.product.price.toString()),
            subtotal: int.parse(widget.product.price.toString()) *
                (int.tryParse(widget.product.quantity ?? '0') ?? 0)));

        context.read<CompanyDetailBloc>().add(
            GetCompanyProducts(widget.companyId.toString(), currentPage: 1));
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: selectedProductInfoList.isEmpty
          ? SizedBox()
          : SingleChildScrollView(
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
                            type: widget.type,
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
                          title: widget.type == 'tender'
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: ColorResources.lgColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                      onTap: widget.type == 'tender'
                                          ? () {
                                              context
                                                  .read<TendersBloc>()
                                                  .add(ClearSelectedTender());

                                              List<int> tenderIds =
                                                  selectedProductInfoList
                                                      .map((e) =>
                                                          e.tenderItem.id ?? 0)
                                                      .toList();
                                              Get.back();
                                              Get.to(
                                                  () =>
                                                      SelectCompanyTenderScreen(
                                                        alreadySelectedItems:
                                                            tenderIds,
                                                        onSelect: (val) async {
                                                          Get.back();

                                                          if (val != null) {
                                                            setState(() {
                                                              selectedProductInfoList.add(SelectedProductInfo(
                                                                  product:
                                                                      ProductListItem(),
                                                                  tenderItem:
                                                                      val,
                                                                  totalQuantity:
                                                                      int.tryParse(val.quantity ??
                                                                              '0') ??
                                                                          0,
                                                                  unitPrice:
                                                                      val.budgetFrom ??
                                                                          0,
                                                                  subtotal: int
                                                                          .parse(
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
                                                      .map((e) =>
                                                          e.product.id ?? 0)
                                                      .toList();

                                              print(
                                                  'this is the selected products ids = $selectedProducts');
                                              Get.back();
                                              Get.to(() => SelectCompanyProduct(
                                                    isSelectProduct: true,
                                                    selectedProducts:
                                                        selectedProducts,
                                                    onSendProduct: () async {
                                                      Get.back();

                                                      // Get the selected product from Bloc (you can change this based on your logic)
                                                      ProductListItem?
                                                          selectedProduct =
                                                          context
                                                              .read<
                                                                  ProductBloc>()
                                                              .state
                                                              .selectedProduct;

                                                      if (selectedProduct !=
                                                          null) {
                                                        setState(() {
                                                          selectedProductInfoList.add(SelectedProductInfo(
                                                              product:
                                                                  selectedProduct,
                                                              tenderItem:
                                                                  TenderItem(),
                                                              totalQuantity:
                                                                  int.tryParse(selectedProduct
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
                                      onTap: widget.type == 'tender'
                                          ? () {
                                              context
                                                  .read<TendersBloc>()
                                                  .add(ClearSelectedTender());

                                              List<int> tenderIds =
                                                  selectedProductInfoList
                                                      .map((e) =>
                                                          e.tenderItem.id ?? 0)
                                                      .toList();
                                              Get.back();
                                              Get.to(
                                                  () =>
                                                      SelectCompanyTenderScreen(
                                                        alreadySelectedItems:
                                                            tenderIds,
                                                        onSelect: (val) async {
                                                          Get.back();

                                                          if (val != null) {
                                                            setState(() {
                                                              selectedProductInfoList.add(SelectedProductInfo(
                                                                  product:
                                                                      ProductListItem(),
                                                                  tenderItem:
                                                                      val,
                                                                  totalQuantity:
                                                                      int.tryParse(val.quantity ??
                                                                              '0') ??
                                                                          0,
                                                                  unitPrice:
                                                                      val.budgetFrom ??
                                                                          0,
                                                                  subtotal: int
                                                                          .parse(
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
                                                      .map((e) =>
                                                          e.product.id ?? 0)
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
                                                          selectedProduct =
                                                          context
                                                              .read<
                                                                  ProductBloc>()
                                                              .state
                                                              .selectedProduct;

                                                      if (selectedProduct !=
                                                          null) {
                                                        setState(() {
                                                          selectedProductInfoList.add(SelectedProductInfo(
                                                              product:
                                                                  selectedProduct,
                                                              tenderItem:
                                                                  TenderItem(),
                                                              totalQuantity:
                                                                  int.tryParse(selectedProduct
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
                                      // onTap: () {
                                      //   Get.back();
                                      //   Get.to(() => ProductScreen(
                                      //         isSelectProduct: true,
                                      //         onSendProduct: () async {
                                      //           Get.back();

                                      //           ProductListItem? selectedProduct =
                                      //               context
                                      //                   .read<ProductBloc>()
                                      //                   .state
                                      //                   .selectedProduct;

                                      //           if (selectedProduct != null) {
                                      //             setState(() {
                                      //               selectedProductInfoList.add(
                                      //                   SelectedProductInfo(
                                      //                       product: selectedProduct,
                                      //                       tenderItem: TenderItem(),
                                      //                       totalQuantity: int.tryParse(
                                      //                               selectedProduct
                                      //                                       .quantity ??
                                      //                                   '0') ??
                                      //                           0,
                                      //                       unitPrice: selectedProduct
                                      //                               .price ??
                                      //                           0,
                                      //                       subtotal: int.parse(
                                      //                               selectedProduct
                                      //                                   .quantity!) *
                                      //                           selectedProduct
                                      //                               .price!));
                                      //               // selectedProducts
                                      //               //     .add(selectedProduct);
                                      //             });
                                      //           }
                                      //         },
                                      //       ));
                                      // },
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
                    // Get.back();
                    Get.to(() => NewContactListScreen(
                          selectedProductsList: selectedProductInfoList,
                          buyerId: widget.buyerId,
                          type: widget.type,
                          productId: widget.type == 'tender'
                              ? '0'
                              : widget.product.id.toString(),
                          tenderId: widget.type == 'tender'
                              ? widget.tenderItem.id.toString()
                              : '0',
                          contractName: contractNameController.text.trim(),
                          companyId: widget.companyId,
                        ));
                  },
            title: 'continue'.tr),
      ),
    );
  }
}
