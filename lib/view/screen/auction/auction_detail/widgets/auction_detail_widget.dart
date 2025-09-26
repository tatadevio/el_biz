import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/model/response/auction/auction_detail_model.dart';
import '../../../../../helper/date_helper.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';

class AuctionDetailWidget extends StatelessWidget {
  final AuctionDetailData auction;
  const AuctionDetailWidget({super.key, required this.auction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'description'.tr,
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            auction.product?.description ?? '',

            // tenderDetail.data?.description ?? '',
            //  'Ищу поставщиков садовой мебели, конкретно раскладных стульев хорошего качества, из натуральных материалов, с интересным дизайном, 20 штук желательно похожих или в двух расцветках.',
            style: body14.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'product'.tr,
            style: body14.copyWith(fontWeight: FontWeight.w700),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 4),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'technique'.tr,
          //         style: body14,
          //       ),
          //       Text(
          //         'coal'.tr,
          //         style: body14,
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'material'.tr,
                  style: body14,
                ),
                Text(
                  auction.product?.material ?? '',
                  // 'dense_art_paper'.tr,
                  style: body14,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'dimention'.tr,
                  style: body14,
                ),
                Text(
                  auction.product?.dimention ?? '',
                  // '70 ${'cm'.tr}',
                  style: body14,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'weight'.tr,
                  style: body14,
                ),
                Text(
                  auction.product?.weight ?? '',
                  // '100 ${'cm'.tr}',
                  style: body14,
                ),
              ],
            ),
          ),
          // productInfoWidget(
          //     title: 'Товар: ',
          //     value: 'Количество',
          //     titleBold: true,
          //     valueBold: true),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: tenderDetail.data?.tenderProducts?.length ?? 0,
          //   itemBuilder: (context, index) {
          //     final tenderProduct =
          //         tenderDetail.data!.tenderProducts![index];
          //     return productInfoWidget(
          //         title: tenderProduct.productName,
          //         value:
          //             "${tenderProduct.quantity} ${tenderProduct.unit}"
          //         // '20шт',
          //         );
          //   },
          // ),
          // productInfoWidget(title: 'Диваны', value: '20шт'),
          // productInfoWidget(title: 'Шкафы', value: '20шт'),
          // productInfoWidget(
          //     title: 'Бюджет: ',
          //     value: '50 000 сом',
          //     valueBold: true),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'published'.tr,
                style: body14.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                formatDateInRu(auction.startDate.toString()),
                // '24.10.2024, 18:10',
                style: body14.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${"completed".tr}:',
                style: body14.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                formatDateInRu(auction.endDate.toString()),
                // '24.10.2024, 18:10',
                style: body14.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
