import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/contracts/contracts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../helper/date_helper.dart';

class ContractTileWidget extends StatelessWidget {
  final CompanyItem contractData;
  final bool isSales;
  // final String? lastMessage;
  const ContractTileWidget({
    super.key,
    required this.contractData,
    required this.isSales,
    // this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //go to the agrement/contracts screen.
        if(isSales) {

        context.read<ContractsBloc>().add(GetCompanySales(companyId: contractData.id.toString(), currentPage: 1));
        }else {
        context.read<ContractsBloc>().add(GetCompanyPurchases(
              companyId: contractData.id.toString(), currentPage: 1));

        }
        Get.to(() => ContractsScreen(isSale: isSales, contractId: contractData.id.toString(),));
      },
      leading: CustomImage(image: '', height: 48, width: 48, radius: 48),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              contractData.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
          ),
          Text(
            formatDateInRu(contractData.createdAt.toString()),
            // '24 окт',
            style: body12.copyWith(color: ColorResources.gray),
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              contractData.description ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              // 'Мебель для предприятий и для дома',
              style: body14.copyWith(color: ColorResources.gray),
            ),
          ),
          // if (unSeen)
          //   Icon(
          //     Icons.circle,
          //     color: ColorResources.green,
          //     size: 10,
          //   ),
        ],
      ),
    );
  }
}
