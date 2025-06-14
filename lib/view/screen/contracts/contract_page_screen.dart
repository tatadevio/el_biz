import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/screen/contracts/sign_contract_screen.dart';
import 'package:el_biz/view/screen/contracts/widgets/bill_pay_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

//import '../../../data/model/base/contract_model.dart';
import '../../../data/model/response/agreement/company_sales_model.dart';
import 'widgets/show_contract_files.dart';

class ContractPageScreen extends StatelessWidget {
  final CompanyContractItem contractModel;
  const ContractPageScreen({super.key, required this.contractModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              'Номер договора',
              Text(
                contractModel.id.toString(),
                // contractModel.id,
                style: body16.copyWith(color: ColorResources.titleColor),
              ),
            ),
            dataItem(
              'Название договора',
              Text(
                contractModel.contractName ?? '',
                style: body16.copyWith(color: ColorResources.titleColor),
              ),
            ),
            dataItem(
              'Количество товаров(ед)',
              Text(
                contractModel.contractProducts?.length.toString() ?? '0',
                style: body16.copyWith(color: ColorResources.titleColor),
              ),
            ),
            dataItem(
              'Стоимость заказа',
              Text(
                contractModel.totalAmount.toString(),
                style: body16.copyWith(color: ColorResources.titleColor),
              ),
            ),
            dataItem(
              'Дата заказа',
              Text(
                contractModel.createdAt != null
                    ? formatDateInRu(contractModel.createdAt.toString())
                    : '',
                style: body16.copyWith(color: ColorResources.titleColor),
              ),
            ),
            dataItem(
              'Статус согласования:',
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                decoration: BoxDecoration(
                  color: contractModel.status == "Подписан"
                      ? ColorResources.green
                      : contractModel.status == "Отклонён"
                          ? ColorResources.errorInput
                          : ColorResources.orange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  contractModel.status ?? '',
                  style: body14.copyWith(color: ColorResources.white),
                ),
              ),
            ),
            dataItem(
              'payment_status'.tr,
              Text(
                contractModel.status ?? '',
                style: body16.copyWith(
                    fontWeight: FontWeight.w500,
                    color: contractModel.status == "Оплачен"
                        ? ColorResources.green
                        : ColorResources.red),
              ),
            ),
            dataItem(
              'Статус оплаты',
              InkWell(
                onTap: () {
                  Get.bottomSheet(const ShowContractFiles(),
                      backgroundColor: Colors.white, isScrollControlled: true);
                },
                child: Container(
                  // height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorResources.blue,
                    border: Border.all(width: 1, color: ColorResources.blue),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [ColorResources.shadow1],
                  ),
                  child: Text(
                    'document',
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
                        const CustomDialog(
                          widget: AlertDialog(
                              backgroundColor: Colors.white,
                              content: BillPayDialog()),
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            if (context.read<UserBloc>().state.userInfo!.data?.id != null &&
                contractModel.seller?.id ==
                    context.read<UserBloc>().state.userInfo!.data?.id)
              Expanded(
                child: CustomBorderButton(
                  height: 44,
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: Border.all(width: 1, color: ColorResources.blue),
                  borderRadius: BorderRadius.circular(12),
                  boxShaow: const [ColorResources.shadow1],
                  child: Text(
                    'edit'.tr,
                    style: textMd.copyWith(color: ColorResources.blue),
                  ),
                  onTap: () {},
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            // if (context.read<UserBloc>().state.userInfo!.data?.id != null &&
            //     contractModel.seller?.id !=
            //         context.read<UserBloc>().state.userInfo!.data?.id)
            Expanded(
              child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    Get.to(() => SignContractScreen(
                          contractData: contractModel,
                        ));
                  },
                  title: 'signing'.tr),
            ),
          ],
        ),
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
