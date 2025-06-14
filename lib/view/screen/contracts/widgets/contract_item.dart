import 'package:el_biz/data/model/response/agreement/company_sales_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../helper/date_helper.dart';
import '../contract_page_screen.dart';

class ContractItem extends StatelessWidget {
  final CompanyContractItem contractModel;
  const ContractItem({super.key, required this.contractModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Get.to(() => ContractPageScreen(contractModel: contractModel));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 24.3,
                spreadRadius: 0,
                offset: Offset(1, 0),
                color: Color.fromRGBO(0, 20, 40, 0.06),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      contractModel.contractName ?? '',
                      // contractModel.title,
                      style: body16.copyWith(color: ColorResources.blue),
                    ),
                  ),
                  Text(
                    contractModel.createdAt != null
                        ? formatDateInRu(contractModel.createdAt.toString())
                        : '',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                contractModel.status ?? '',
                // contractModel.subTitle,
                style: body14.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                contractModel.paymentMethod ?? '',
                // contractModel.paymentStatus,
                style: body14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: contractModel.status == "Оплачен"
                        ? ColorResources.green
                        : ColorResources.red),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(Images.svgArrowRight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
