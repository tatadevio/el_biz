import 'package:el_biz/bloc/auction/similar_auctions/similar_auctions_bloc.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/auction/auction_detail/auction_detail_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/similar_tenders/similar_tenders_bloc.dart';
import '../../data/model/response/tender/tender_item_model.dart';
import '../../utils/Images.dart';
import '../screen/auction/auction_detail/auction_detail_screen.dart';
import '../screen/tender/tender_detail_screen.dart';

class AuctionGridItem extends StatelessWidget {
  // final bool isFavorite;
  // final TenderItem tender;
  // final bool isCompanyTender;
  // final bool isPublicTender;
  // final bool isSelect;
  // final bool isAlreadySelect;
  // final bool isSearchTender;
  const AuctionGridItem({
    super.key,
    // this.isFavorite = false,
    // required this.tender,
    // required this.isCompanyTender,
    // this.isPublicTender = false,
    // this.isSelect = false,
    // this.isAlreadySelect = false,
    // this.isSearchTender = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<AuthBloc>().state.isLoggedIn) {
          final auctionId = '';
          context
              .read<AuctionDetailBloc>()
              .add(GetAuctionDetail(auctionId: auctionId));
          context.read<SimilarAuctionsBloc>().add(
                GetSimilarAuctions(
                  auctionId: auctionId,
                  // tender.id.toString(),
                  currentPage: 1,
                ),
              );
          Get.to(() => AuctionDetailScreen(
                auctionName: '',
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
                      image: '',
                      height: Get.height,
                      width: Get.width,
                      radius: 16),
                  // Image.asset(Images.splashLogo),

                  Positioned(
                      right: 5,
                      top: 5,
                      child: CustomFavoriteButton(
                        isFavorite: false,
                        // tender.isFavorite ?? false,
                        onTap: () {
                          // if (isCompanyTender) {
                          //   context
                          //       .read<CompanyDetailBloc>()
                          //       .add(ToggleTenderFavorite(tender.id!, context));
                          // } else if (isSearchTender) {
                          //   context.read<SearchTenderBloc>().add(
                          //       ToggleSearchTenderFavorite(
                          //           tender.id!, context));
                          // } else
                          // // if (isPublicTender)
                          // {
                          //   context.read<PublicTenderBloc>().add(
                          //       TogglePublicTenderFavorite(
                          //           tender.id!, context));
                          // }
                        },
                      )
                      // CustomLikeButton(isFavorite: isFavorite),
                      ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 243, 243, 0.7),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.svgClock),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '6дн 20ч',
                            style: textStyle13Inter.copyWith(
                                color:
                                    ColorResources.darkGray.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  )
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
                  // tender.title ?? '',
                  '200\$',
                  style: h16.copyWith(color: ColorResources.blue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  // tender.description ?? '',
                  'Silvie Mahdal art',
                  style: h16.copyWith(color: ColorResources.darkGray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Живопись и графика',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: body14.copyWith(color: ColorResources.gray),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: ColorResources.darkGray.withOpacity(0.8),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Бишкек', // location
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: body14.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorResources.darkGray.withOpacity(0.8)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      Images.svgPersons,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '50 ставок', // location
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: body14.copyWith(
                          color: ColorResources.darkGray.withOpacity(0.8)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Юр.лицо',
                      style: textStyle13Inter.copyWith(
                          color: ColorResources.darkGray.withOpacity(0.8)),
                    ),
                    Text(
                      formatDateInRu(DateTime.now().toString()),
                      style: textStyle13Inter.copyWith(
                          color: ColorResources.darkGray.withOpacity(0.8)),
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
