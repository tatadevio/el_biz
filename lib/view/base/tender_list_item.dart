import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/company_detail/company_detail_bloc.dart';
import '../../bloc/public_tender/public_tender_bloc.dart';
import '../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../data/model/response/tender/tender_item_model.dart';
import '../../helper/date_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/tender/tender_detail_screen.dart';
import 'check_box_tender_button.dart';
import 'custom_favorite_button.dart';
import 'custom_toast.dart';

class TenderListItem extends StatelessWidget {
  final bool isFavorite;
  final TenderItem tender;
  final bool isCompanyTender;
  final bool isPublicTender;
  final bool isSelect;
  final bool isAlreadySelect;

  const TenderListItem({
    super.key,
    this.isFavorite = false,
    required this.tender,
    this.isCompanyTender = false,
    this.isPublicTender = false,
    this.isSelect = false,
    this.isAlreadySelect = false,
  });

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
                  CustomImage(
                      image: tender.image ?? '',
                      height: 120,
                      width: 100,
                      radius: 16),
                  if (isSelect && !isAlreadySelect) ...[
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CheckBoxTenderButton(
                        product: tender,
                      ),
                    ),
                  ],
                  if (isSelect && isAlreadySelect)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Checkbox(
                          value: true,
                          // checkBoxValue(state.selectedProduct.id ?? [], widget.productId!),
                          onChanged: (val) {
                            showShortToast("${tender.title} уже добавлен");
                          }),
                    ),
                  if (!isSelect)
                    Positioned(
                        right: 5,
                        top: 5,
                        child: CustomFavoriteButton(
                          isFavorite: tender.isFavorite ?? false,
                          onTap: () {
                            if (isCompanyTender) {
                              context.read<CompanyDetailBloc>().add(
                                  ToggleTenderFavorite(tender.id!, context));
                            } else
                            // if (isPublicTender)
                            {
                              context.read<PublicTenderBloc>().add(
                                  TogglePublicTenderFavorite(
                                      tender.id!, context));
                            }
                          },
                        )),
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
