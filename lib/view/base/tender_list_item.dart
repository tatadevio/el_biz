import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../data/model/response/tender/tender_item_model.dart';
import '../../helper/date_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/tender/tender_detail_screen.dart';

class TenderListItem extends StatelessWidget {
  final bool isFavorite;
  final TenderItem tender;
    final bool isCompanyTender;
  final bool isPublicTender;

  const TenderListItem(
      {super.key, this.isFavorite = false, required this.tender, this.isCompanyTender = false, this.isPublicTender = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          context
              .read<TenderDetailBloc>()
              .add(GetTenderDetail(tenderId: tender.id.toString()));
          Get.to(() => TenderDetailScreen(
                // isProduct: false,
                tenderName: tender.title ?? '',
              ));
        },
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                children: [
                  CustomImage(image: '', height: 120, width: 100, radius: 16),
                  Positioned(
                    right: 10,
                    top: 5,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 1),
                            color: Color.fromRGBO(16, 24, 40, 0.05),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        isFavorite ? Images.svgHeart : Images.svgHeartBorder,
                        color: isFavorite ? ColorResources.primaryRed : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tender.title ?? '',
                          // 'Садовая мебель, раскладные стулья',
                          style: h16.copyWith(color: ColorResources.darkGray),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          tender.description ?? '',
                          style: body14.copyWith(color: ColorResources.gray),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Количество:${tender.quantity} шт',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: body14.copyWith(
                              color: Color.fromRGBO(71, 84, 103, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Бюджет: ${tender.budgetFrom} - ${tender.budgetTo} сом',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: body14.copyWith(
                              color: Color.fromRGBO(71, 84, 103, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Юр.лицо',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                        Text(
                          formatDateInRu(tender.createdAt.toString()),
                          style: body14.copyWith(color: ColorResources.gray),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
