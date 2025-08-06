import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/bloc/search_tender/search_tender_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/check_box_tender_button.dart';
import 'package:el_biz/view/base/custom_favorite_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/similar_tenders/similar_tenders_bloc.dart';
import '../../data/model/response/tender/tender_item_model.dart';
import '../screen/tender/tender_detail_screen.dart';

class TenderGridItem extends StatelessWidget {
  final bool isFavorite;
  final TenderItem tender;
  final bool isCompanyTender;
  final bool isPublicTender;
  final bool isSelect;
  final bool isAlreadySelect;
  final bool isSearchTender;
  const TenderGridItem({
    super.key,
    this.isFavorite = false,
    required this.tender,
    required this.isCompanyTender,
    this.isPublicTender = false,
    this.isSelect = false,
    this.isAlreadySelect = false,
    this.isSearchTender = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<AuthBloc>().state.isLoggedIn) {
          context
              .read<TenderDetailBloc>()
              .add(GetTenderDetail(tenderId: tender.id.toString()));
          context.read<SimilarTendersBloc>().add(GetSimilarTenders(
              tenderId: tender.id.toString(), currentPage: 1));
          Get.to(() => TenderDetailScreen(
                // isProduct: false,
                tenderName: tender.title ?? '',
              ));
        } else {
          showShortToast('login_to_view_tender'.tr);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            // border: Border.all(
            //   width: 1,
            //   color: ColorResources.lgColor,
            // ),
            ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CustomImage(
                      image: tender.image ?? '',
                      height: Get.height,
                      width: Get.width,
                      radius: 16),
                  // Image.asset(Images.splashLogo),
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
                            } else if (isSearchTender) {
                              context.read<SearchTenderBloc>().add(
                                  ToggleSearchTenderFavorite(
                                      tender.id!, context));
                            } else
                            // if (isPublicTender)
                            {
                              context.read<PublicTenderBloc>().add(
                                  TogglePublicTenderFavorite(
                                      tender.id!, context));
                            }
                          },
                        )
                        // CustomLikeButton(isFavorite: isFavorite),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
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
                  // 'Раскладной садовый стул из дерева',
                  style: body14.copyWith(color: ColorResources.gray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Количество:  ${tender.quantity} шт', // quantity
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: body14.copyWith(
                      color: const Color.fromRGBO(71, 84, 103, 1)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Бюджет: ${tender.budgetFrom} - ${tender.budgetTo}сом',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: body14.copyWith(
                      color: const Color.fromRGBO(71, 84, 103, 1)),
                ),
                const SizedBox(
                  height: 5,
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
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
