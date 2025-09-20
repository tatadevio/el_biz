import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/auction/auction_detail/auction_detail_bloc.dart';
import '../../bloc/auction/similar_auctions/similar_auctions_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/auction/auction_detail/auction_detail_screen.dart';
import 'custom_favorite_button.dart';
import 'custom_toast.dart';

class AuctionListItemWidget extends StatelessWidget {
  final bool isFavorite;
  final AuctionListItem auction;
  final bool isCompanyAuction;
  final bool isPublicAuction;
  // final bool isSelect;
  // final bool isAlreadySelect;
  final bool isSearchAuction;

  const AuctionListItemWidget({
    super.key,
    this.isFavorite = false,
    required this.auction,
    this.isCompanyAuction = false,
    this.isPublicAuction = false,
    // this.isSelect = false,
    // this.isAlreadySelect = false,
    this.isSearchAuction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          if (context.read<AuthBloc>().state.isLoggedIn) {
            // final auctionId =  auction.id ?? '';
            context
                .read<AuctionDetailBloc>()
                .add(GetAuctionDetail(auctionId: auction.id.toString()));
            context.read<SimilarAuctionsBloc>().add(
                  GetSimilarAuctions(
                    auctionId: auction.id.toString(),
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
        child: SizedBox(
          height: 130,
          child: Stack(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CustomImage(
                          image: '', height: 104, width: 102, radius: 16),
                      Positioned(
                          right: 5,
                          top: 5,
                          child: CustomFavoriteButton(
                            isFavorite: false,
                            // auction.isFavorite ?? false,
                            onTap: () {
                              // if (isCompanyTender) {
                              //   context.read<CompanyDetailBloc>().add(
                              //       ToggleTenderFavorite(tender.id!, context));
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
                              // '200\$',
                              auction.buyoutPrice ?? auction.productPrice ?? '',
                              style: h16.copyWith(color: ColorResources.blue),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              auction.title ?? '',
                              // 'Silvie Mahdal art',
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              auction.product?.description ?? '',
                              // 'Живопись и графика',
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color:
                                      ColorResources.darkGray.withOpacity(0.8),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  auction.location ?? '',
                                  // 'Бишкек',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: body14.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.darkGray
                                          .withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(Images.svgPersons),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${auction.bidCount} ставок',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: body14.copyWith(
                                      color: ColorResources.darkGray
                                          .withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'Юр.лицо',
                        //       style: body14.copyWith(color: ColorResources.gray),
                        //     ),
                        //     Text(
                        //       formatDateInRu(DateTime.now().toString()),
                        //       style: body14.copyWith(color: ColorResources.gray),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 5,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: ColorResources.yellow,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.svgClock),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          // '6дн 20ч',
                          auction.timeRemaining ?? '',
                          style: textStyle13Inter,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
