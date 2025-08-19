import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/screen/contracts/sign_contract_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/bill_pay_dialog.dart';
import 'package:el_biz/view/screen/chat/widgets/full_screen_image.dart';
import 'package:el_biz/view/screen/pdf_viewer/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../data/model/response/agreement/company_sales_model.dart';
import '../../../data/model/response/company/company_product_model.dart';
import '../../../data/model/response/tender/tender_item_model.dart';
import '../../../helper/status_helper.dart';
import '../../base/custom_toast.dart';
import 'new_contract_screen.dart';
import 'widgets/show_contract_files.dart';

class ContractPageScreen extends StatefulWidget {
  // final CompanyContractItem contractModel;
  final int contractId;
  const ContractPageScreen({super.key, required this.contractId});

  @override
  State<ContractPageScreen> createState() => _ContractPageScreenState();
}

class _ContractPageScreenState extends State<ContractPageScreen> {
  CompanyContractItem? contractDetail;

  @override
  void initState() {
    super.initState();
    // Call the GetContractDetail event when screen loads
    context
        .read<ContractsBloc>()
        .add(GetContractDetail(contractId: widget.contractId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          // Call GetContractDetail event to refresh contract data
          context
              .read<ContractsBloc>()
              .add(GetContractDetail(contractId: widget.contractId.toString()));
        },
        child: BlocBuilder<ContractsBloc, ContractsState>(
            builder: (context, state) {
          // Primary: Use data from state.contractDetail
          CompanyContractItem? tempContractModel = state.contractDetail;

          // Fallback: If contractDetail is null, try to find in salesContractItems list
          if (tempContractModel == null) {
            try {
              tempContractModel = state.salesContractItems
                  .firstWhere((element) => element.id == widget.contractId);
            } catch (e) {
              // Contract not found in list either
            }
          }

          // Show loading if still no data available
          if (state.isLoading || tempContractModel == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Now we have confirmed data, make it non-nullable
          final contractModel = tempContractModel;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    contractModel.contractName ?? '',
                    // contractModel.title,
                    style: body16.copyWith(color: ColorResources.blue),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  dataItem(
                    'contract_number'.tr,
                    Text(
                      contractModel.id.toString(),
                      // contractModel.id,
                      style: body16.copyWith(color: ColorResources.titleColor),
                    ),
                  ),
                  dataItem(
                    'contract_title'.tr,
                    Text(
                      contractModel.contractName ?? '',
                      style: body16.copyWith(color: ColorResources.titleColor),
                    ),
                  ),
                  dataItem(
                    'product_quantity_units'.tr,
                    Text(
                      contractModel.contractProducts?.length.toString() ?? '0',
                      style: body16.copyWith(color: ColorResources.titleColor),
                    ),
                  ),
                  dataItem(
                    'order_cost'.tr,
                    Text(
                      contractModel.totalAmount.toString(),
                      style: body16.copyWith(color: ColorResources.titleColor),
                    ),
                  ),
                  dataItem(
                    'order_date'.tr,
                    Text(
                      contractModel.createdAt != null
                          ? formatDateInRu(contractModel.createdAt.toString())
                          : '',
                      style: body16.copyWith(color: ColorResources.titleColor),
                    ),
                  ),
                  dataItem(
                    'approval_status'.tr,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 12),
                      decoration: BoxDecoration(
                        color: contractModel.status?.toLowerCase() == "signed"
                            // "Подписан"
                            ? ColorResources.green
                            : contractModel.status?.toLowerCase() == "declined"
                                // "Отклонён"
                                ? ColorResources.errorInput
                                : ColorResources.orange,
                        // color: contractModel.status == "Подписан"
                        //     ? ColorResources.green
                        //     : contractModel.status == "Отклонён"
                        //         ? ColorResources.errorInput
                        //         : ColorResources.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        StatusHelper.getStatus(contractModel.status ?? ''),
                        style: body14.copyWith(color: ColorResources.white),
                      ),
                    ),
                  ),
                  dataItem(
                    'payment_status'.tr,
                    Text(
                      StatusHelper.getStatus(contractModel.paymentStatus ?? ''),
                      style: body16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: contractModel.paymentStatus == "paid"
                              ? ColorResources.green
                              : ColorResources.red),
                    ),
                  ),
                  dataItem(
                    'documents'.tr,
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(const ShowContractFiles(),
                            backgroundColor: Colors.white,
                            isScrollControlled: true);
                      },
                      child: Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: ColorResources.blue,
                          border:
                              Border.all(width: 1, color: ColorResources.blue),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [ColorResources.shadow1],
                        ),
                        child: Text(
                          'documents'.tr,
                          // contractModel.document,
                          style: body16.copyWith(color: ColorResources.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'has_the_bill_been_paid'.tr,
                    style: h16.copyWith(color: ColorResources.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (context.read<UserBloc>().state.userInfo!.data?.id !=
                          null &&
                      contractModel.seller?.id ==
                          context
                              .read<UserBloc>()
                              .state
                              .userInfo!
                              .data
                              ?.id) ...[
                    if (contractModel.paymentStatus == 'processing')
                      CustomButton(
                        width: Get.width,
                        height: 44,
                        onTap: () {
                          print(contractModel.paymentStatus);
                          String newValue =
                              contractModel.paymentStatus ?? 'processing';
                          Get.dialog(
                            AlertDialog(
                              title: Text('update_payment_status'.tr),
                              content: DropdownButtonFormField<String>(
                                value: contractModel.paymentStatus ?? 'unpaid',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                items: [
                                  // DropdownMenuItem(
                                  //   value: 'unpaid',
                                  //   child: Text('unpaid'.tr),
                                  // ),
                                  DropdownMenuItem(
                                    value: 'processing',
                                    child: Text('processing'.tr),
                                  ),
                                  DropdownMenuItem(
                                    value: 'paid',
                                    child: Text('paid'.tr),
                                  ),
                                  DropdownMenuItem(
                                    value: 'rejected',
                                    child: Text('rejected'.tr),
                                  ),
                                ],
                                onChanged: (value) {
                                  // Handle payment status change
                                  if (value != null) {
                                    newValue = value;
                                  }
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        ColorResources.red.withOpacity(0.1),
                                  ),
                                  child: Text(
                                    'cancel'.tr,
                                    style: TextStyle(
                                      color: ColorResources.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Handle save
                                    context.read<ContractsBloc>().add(
                                        UpdatePaymentStatus(
                                            contractId:
                                                contractModel.id.toString(),
                                            status: newValue));

                                    Get.back();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        ColorResources.blue.withOpacity(0.1),
                                  ),
                                  child: Text(
                                    'save'.tr,
                                    style: TextStyle(
                                      color: ColorResources.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        title: 'update_payment_status'.tr,
                        color: ColorResources.blue,
                      ),
                    if (contractModel.paymentSlips != null &&
                        contractModel.paymentSlips!.isNotEmpty)
                      for (var paymentSlip in contractModel.paymentSlips!)
                        ListTile(
                            onTap: () {
                              if (paymentSlip.url != null) {
                                final url = paymentSlip.url!;
                                final fileName = paymentSlip.name ?? 'Document';

                                // Check if it's a PDF
                                if (url.toLowerCase().endsWith('.pdf')) {
                                  Get.to(() => PdfViewerScreen(
                                        name: fileName,
                                        url: url,
                                      ));
                                }
                                // Check if it's an image
                                else if (url.toLowerCase().endsWith('.png') ||
                                    url.toLowerCase().endsWith('.jpg') ||
                                    url.toLowerCase().endsWith('.jpeg')) {
                                  Get.to(() => FullScreenImage(imageUrl: url));
                                }
                              }
                            },
                            contentPadding: const EdgeInsets.all(0),
                            leading: paymentSlip.url != null
                                ? paymentSlip.url!
                                        .toLowerCase()
                                        .endsWith('.pdf')
                                    ? const Icon(Icons.picture_as_pdf)
                                    : (paymentSlip.url!
                                                .toLowerCase()
                                                .endsWith('.png') ||
                                            paymentSlip.url!
                                                .toLowerCase()
                                                .endsWith('.jpg') ||
                                            paymentSlip.url!
                                                .toLowerCase()
                                                .endsWith('.jpeg'))
                                        ? Hero(
                                            tag: paymentSlip.url!,
                                            child: Image.network(
                                                paymentSlip.url!,
                                                width: 40,
                                                height: 40),
                                          )
                                        : const Icon(Icons.broken_image)
                                : null,
                            title: Text(paymentSlip.name ?? ''),
                            subtitle:
                                Text(paymentSlip.createdAt?.toString() ?? ''),
                            trailing: IconButton(
                                onPressed: () {
                                  ShowContractFiles()
                                      .downloadFileWithScopedPermission(
                                          paymentSlip.url ?? '', context);
                                },
                                icon: Icon(Icons.download))),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            width: Get.width,
                            height: 44,
                            onTap: () {},
                            title: 'not_paid'.tr,
                            color: ColorResources.red,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButton(
                            width: Get.width,
                            height: 44,
                            onTap: () {
                              Get.dialog(
                                CustomDialog(
                                  widget: AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: BillPayDialog(
                                        contractId: contractModel.id.toString(),
                                      )),
                                ),
                              );
                            },
                            title: 'paid'.tr,
                            color: ColorResources.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.white,
        child: BlocBuilder<ContractsBloc, ContractsState>(
            builder: (context, state) {
          // Primary: Use data from state.contractDetail
          CompanyContractItem? tempContractModel = state.contractDetail;

          // Fallback: If contractDetail is null, try to find in salesContractItems list
          if (tempContractModel == null) {
            try {
              tempContractModel = state.salesContractItems
                  .firstWhere((element) => element.id == widget.contractId);
            } catch (e) {
              // Contract not found in list either
            }
          }

          // Return empty widget if no contract data available
          if (tempContractModel == null) {
            return const SizedBox();
          }

          // Now we have confirmed data, make it non-nullable
          final contractModel = tempContractModel;

          return Row(
            children: [
              if (context.read<UserBloc>().state.userInfo!.data?.id != null &&
                  contractModel.seller?.id ==
                      context.read<UserBloc>().state.userInfo!.data?.id)
                Expanded(
                  child: CustomBorderButton(
                    height: 44,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    border: Border.all(width: 1, color: ColorResources.blue),
                    borderRadius: BorderRadius.circular(12),
                    boxShaow: const [ColorResources.shadow1],
                    child: Text(
                      'edit'.tr,
                      style: textMd.copyWith(color: ColorResources.blue),
                    ),
                    onTap: () {
                      // Navigate to edit contract screen
                      // Get.to(() => EditContractScreen(
                      //       contractModel: contractModel,
                      //     ));
                      for (var contractProduct
                          in contractModel.contractProducts ?? []) {
                        print(contractProduct.unitPrice);
                        print(contractProduct.quantity);
                      }
                      Get.to(() => NewContractScreen(
                            product: ProductListItem(),
                            tenderItem: TenderItem(),
                            contractModel: contractModel,
                            buyerId: contractModel.buyer?.id.toString() ?? '',
                            type: contractModel.contractType ?? 'product',
                            companyId: 13,
                            isEditing: true,
                          ));
                    },
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              if (context.read<UserBloc>().state.userInfo!.data?.id != null &&
                  contractModel.seller?.id !=
                      context.read<UserBloc>().state.userInfo!.data?.id)
                Expanded(
                  child: CustomButton(
                      width: Get.width,
                      height: 44,
                      onTap: () {
                        if (contractModel.status?.toLowerCase() == "pending") {
                          Get.to(() => SignContractScreen(
                                contractData: contractModel,
                              ));
                        } else {
                          showShortToast(
                              '${'contract_is'.tr} ${contractModel.status ?? ''}');
                        }
                      },
                      title: 'signing'.tr),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget dataItem(String title, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: body14.copyWith(color: ColorResources.gray),
            ),
          ),
          value,
        ],
      ),
    );
  }
}
