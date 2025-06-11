import 'package:el_biz/data/model/response/agreement/my_sales_model.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/contracts/contracts_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helper/date_helper.dart';

class ContractTileWidget extends StatelessWidget {
  final ContractListItem contractData;
  // final String? lastMessage;
  const ContractTileWidget({
    super.key,
    required this.contractData,
    // this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //go to the agrement/contracts screen.
        Get.to(() => ContractsScreen());
      },
      leading: CustomImage(image: '', height: 48, width: 48, radius: 48),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              contractData.contractName ?? '',
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
              "${contractData.totalAmount} ${AppConstants.currencyCode}",
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
