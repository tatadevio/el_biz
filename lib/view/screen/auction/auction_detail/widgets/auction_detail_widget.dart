import 'package:flutter/material.dart';

import '../../../../../helper/date_helper.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';

class AuctionDetailWidget extends StatelessWidget {
  const AuctionDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Описание',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            // tenderDetail.data?.description ?? '',
            'Ищу поставщиков садовой мебели, конкретно раскладных стульев хорошего качества, из натуральных материалов, с интересным дизайном, 20 штук желательно похожих или в двух расцветках.',
            style: body14.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Товар: ',
            style: body14.copyWith(fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Техника: ',
                  style: body14,
                ),
                Text(
                  'Уголь',
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
                  'Материал: ',
                  style: body14,
                ),
                Text(
                  'Плотная художественная бумага',
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
                  'Ширина:',
                  style: body14,
                ),
                Text(
                  '70 см',
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
                  'Высота:',
                  style: body14,
                ),
                Text(
                  '100 см',
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
                'Опубликовано: ',
                style: body14.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                formatDateInRu(DateTime.now().toString()),
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
