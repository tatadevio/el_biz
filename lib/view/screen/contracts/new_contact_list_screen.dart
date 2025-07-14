import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/data/model/base/selected_product_info.dart';
import 'package:el_biz/data/model/response/agreement/payment_methods_model.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/contracts/widgets/select_payment_method_widget.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/model/response/agreement/company_sales_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_border_button.dart';
import '../../base/custom_dialog.dart';

class NewContactListScreen extends StatefulWidget {
  final List<SelectedProductInfo> selectedProductsList;
  final String buyerId;
  final String type;
  final String productId;
  final String tenderId;
  final String contractName;
  final int companyId;
  final bool isEditing;
  final int? contractId;
  final CompanyContractItem? contractModel;
  const NewContactListScreen({
    super.key,
    required this.selectedProductsList,
    required this.buyerId,
    required this.type,
    required this.productId,
    required this.tenderId,
    required this.contractName,
    required this.companyId,
    this.isEditing = false,
    this.contractId,
    this.contractModel,
  });

  @override
  State<NewContactListScreen> createState() => _NewContactListScreenState();
}

class _NewContactListScreenState extends State<NewContactListScreen> {
  final TextEditingController vatController = TextEditingController();
  final TextEditingController nspController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  PaymentMethod? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    vatController.text = '0';
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
    if (widget.isEditing) {
      vatController.text = widget.contractModel?.vatRate.toString() ?? '0';
      nspController.text = widget.contractModel?.npsRate.toString() ?? '0';
    }
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
      body: BlocListener<AgreementBloc, AgreementState>(
        listener: (context, state) {
          if (state is AddAgreementSuccess) {
            // Handle success state
            // Get.back();
            Get.until((route) => Get.currentRoute == '/DashboardScreen');
            showShortToast(state.message);
            Get.dialog(
              CustomDialog(
                widget: AlertDialog(
                  backgroundColor: Colors.white,
                  content: Column(
                    spacing: 15,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Images.done,
                      ),
                      Text(
                        'the_contract_was_successfully_drawn_up'.tr,
                        style: h16.copyWith(
                          color: ColorResources.titleColor,
                        ),
                      ),
                      Text(
                        'sign_the_contract_and_send_it_to_the_customer'.tr,
                        style: body14.copyWith(color: ColorResources.gray),
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: CustomBorderButton(
                              height: 44,
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              border: Border.all(
                                  width: 1, color: ColorResources.blue),
                              borderRadius: BorderRadius.circular(8),
                              boxShaow: const [ColorResources.shadow1],
                              child: Text(
                                'back'.tr,
                                style:
                                    textMd.copyWith(color: ColorResources.blue),
                              ),
                              onTap: () {
                                Get.back();
                                // Get.offAll(() => DashboardScreen());
                              },
                            ),
                          ),
                          // Expanded(
                          //   child: CustomButton(
                          //     width: Get.width,
                          //     height: 44,
                          //     onTap: () {

                          //       // Get.back();
                          //       // Get.to(() => ContractConditionsScreen());
                          //     },
                          //     title: 'look'.tr,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
            // showShortToast('agreement_added_successfully'.tr);
          } else if (state is AddAgreementError) {
            // Handle failure state
            showShortToast(state.error);
          }
        },
        child: Stack(
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
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: widget.selectedProductsList.length,
                            itemBuilder: (context, index) {
                              return productData(
                                  widget.selectedProductsList[index]);
                            },
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Divider(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SelectPaymentMethodWidget(
                        paymentMethod: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                            nspController.text =
                                selectedPaymentMethod?.nsp.toString() ?? '0';
                          });
                        },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            onChanged: (p0) {
                              setState(() {});
                            },
                          ),
                          CustomTextField1(
                            controller: nspController,
                            hintColor: '%',
                            inputType: TextInputType.text,
                            lableText: 'НсП',
                            leading: '',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            readOnly: false,
                            onChanged: (p0) {
                              setState(() {});
                            },
                          ),
                          SizedBox(),
                          productItem('${"total_excluding_taxes".tr}:',
                              '${calculateTotal()} ${AppConstants.currencyCode}'),
                          productItem('${"including_VAT".tr}:',
                              '${calculateVapTax()} ${AppConstants.currencyCode}'),
                          productItem('${"including_NSP".tr}:',
                              '${calculateNspTax()} ${AppConstants.currencyCode}'),
                          productItem('${"total_payment".tr}:',
                              '${totalPaymnet()} ${AppConstants.currencyCode}'),
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
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: BlocBuilder<AgreementBloc, AgreementState>(
            builder: (context, state) {
          if (state.isLoading) {
            return CustomButtonLoader(width: Get.width, height: Get.height);
          }
          return CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              // Get.to(() => NewContractPaymentScreen());
              print(
                  "this is buyerid = ${widget.buyerId}, vat = ${vatController.text}, nsp = ${nspController.text}");
              print(
                  "selected card = ${selectedPaymentMethod?.type}, vat = ${widget.selectedProductsList[0].subtotal}}, nsp = ${nspController.text}");
              if (selectedPaymentMethod == null) {
                showShortToast('select_payment_method'.tr);
                return;
              }

              Map<String, dynamic> agreementData = {
                'contract_type': widget.type,
                'buyer_id': widget.buyerId,
                'product_id': widget.contractModel == null
                    ? widget.productId
                    : widget.contractModel?.productId.toString() == "0"
                        ? ""
                        : widget.contractModel?.productId.toString(),
                'tender_id': widget.contractModel == null
                    ? widget.tenderId
                    : widget.contractModel?.tenderId.toString() == "0"
                        ? ""
                        : widget.contractModel?.tenderId.toString(),
                // widget.tenderId,
                'contract_name': widget.contractName,
                'vat_rate': vatController.text.trim(),
                'nps_rate': nspController.text.trim(),
                'payment_method': selectedPaymentMethod?.type ?? '',
                'bank_account_id': '',
                'products': widget.type == 'tender'
                    ? widget.selectedProductsList
                        .map((product) => {
                              'id': product.tenderItem.id.toString(),
                              'product_name':
                                  product.tenderItem.title.toString(),
                              'quantity': product.totalQuantity.toString(),
                              'price': product.unitPrice.toString(),
                            })
                        .toList()
                    : widget.selectedProductsList
                        .map((product) => {
                              'id': product.product.id.toString(),
                              'product_name': product.product.name.toString(),
                              'quantity': product.totalQuantity.toString(),
                              'price': product.unitPrice.toString(),
                            })
                        .toList(),

                'seller_company_id': widget.companyId.toString(),
              };

              // Add contract ID if editing
              if (widget.isEditing && widget.contractId != null) {
                agreementData['contract_id'] = widget.contractId.toString();
              }

              if (widget.contractModel != null) {
                // update contract...

                context.read<AgreementBloc>().add(UpdateAgreement(
                    data: agreementData,
                    contractId: widget.contractModel?.id.toString() ?? ''));
              } else {
                // add new contract

                context
                    .read<AgreementBloc>()
                    .add(AddAgreement(data: agreementData));
              }
            },
            title: widget.contractModel != null
                ? 'save_changes'.tr
                : 'continue'.tr,
          );
        }),
      ),
    );
  }

  Widget productData(SelectedProductInfo selectedProduct) {
    return Column(
      spacing: 10,
      children: [
        productItem(
            'Номер товара:',
            widget.type == 'tender'
                ? selectedProduct.tenderItem.id.toString()
                : selectedProduct.product.id.toString()
            // '1',

            ),
        productItem(
            'Наименование товара:',
            widget.type == 'tender'
                ? selectedProduct.tenderItem.title ?? ''
                : selectedProduct.product.name ?? ''
            // 'Стул раскладной',
            ),
        productItem(
            'Количество товаров(ед):', '${selectedProduct.totalQuantity} шт'),
        productItem('Цена за единицу:',
            '${selectedProduct.unitPrice} ${AppConstants.currencyCode}'),
        productItem('Общая стоимость:',
            '${selectedProduct.subtotal} ${AppConstants.currencyCode}'),
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

  String calculateTotal() {
    int total = 0;
    for (var prod in widget.selectedProductsList) {
      total += prod.subtotal;
    }
    return total.toStringAsFixed(1);
  }

  String calculateVapTax() {
    double vapValue = double.tryParse(vatController.text) ?? 0.0;
    double totalSubTotal = double.tryParse(calculateTotal()) ?? 0;
    double total = ((totalSubTotal * vapValue) / 100);
    return total.toStringAsFixed(1);
  }

  String calculateNspTax() {
    double nspTaxValue = double.tryParse(nspController.text) ?? 0.0;
    double totalSubTotal = double.tryParse(calculateTotal()) ?? 0;
    double total = ((totalSubTotal * nspTaxValue) / 100);
    return total.toStringAsFixed(1);
  }

  String totalPaymnet() {
    double subTotal = double.tryParse(calculateTotal()) ?? 0.0;
    double totalVATTax = double.tryParse(calculateVapTax()) ?? 0.0;
    double totalNspTax = double.tryParse(calculateNspTax()) ?? 0.0;

    double totalPayment = subTotal + totalVATTax + totalNspTax;
    return totalPayment.toStringAsFixed(1);
  }
}
