import 'package:el_biz/bloc/auction/similar_auctions/similar_auctions_bloc.dart';
import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../bloc/auction/auction_detail/auction_detail_bloc.dart';
import '../../../../../bloc/auth/auth_bloc.dart';
import '../../../../../utils/Images.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_favorite_button.dart';
import '../../../../base/custom_image.dart';
import '../../../../base/custom_toast.dart';
import '../auction_detail_screen.dart';

class SimilarAuctionWidget extends StatelessWidget {
  final int auctionId;
  final String auctionName;
  final bool isSearch;
  const SimilarAuctionWidget(
      {super.key, required this.auctionId, required this.auctionName, required this.isSearch});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final similarTenderBloc = context.read<SimilarAuctionsBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !similarTenderBloc.state.isLoading &&
          !similarTenderBloc.state.isMoreLoading) {
        int pageSize = similarTenderBloc.state.totalPages;
        if (similarTenderBloc.state.currentPage < pageSize) {
          int nextPage = similarTenderBloc.state.currentPage;

          similarTenderBloc.add(GetSimilarAuctions(
              auctionId: auctionId.toString(), currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _callScrolling(context, _scrollController);
    return BlocBuilder<SimilarAuctionsBloc, SimilarAuctionsState>(
      builder: (context, similarAuctionsState) {
        print(
            'this is the similar tender state ${similarAuctionsState.similarAuctions.length}');
        return similarAuctionsState.similarAuctions.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'similar_auctions'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      height: Get.width * 0.4,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  similarAuctionsState.similarAuctions.length,
                              itemBuilder: (context, index) {
                                return similarTenderItem(
                                    context,
                                    similarAuctionsState
                                        .similarAuctions[index]);
                              },
                            ),
                            if (similarAuctionsState.isMoreLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ).paddingOnly(bottom: 80),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }

  Widget similarTenderItem(BuildContext context, AuctionListItem auction,
      {bool isVerifiedSupplier = false}) {
    double width = Get.width;
    return SizedBox(
      width: width * 0.83,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: InkWell(
          onTap: () {
            // if (context.read<AuthBloc>().state.isLoggedIn) {
            //   context
            //       .read<TenderDetailBloc>()
            //       .add(GetTenderDetail(tenderId: tender.id.toString()));
            //   context.read<SimilarTendersBloc>().add(GetSimilarTenders(
            //       tenderId: tender.id.toString(), currentPage: 1));
            //   Get.to(() => TenderDetailScreen(
            //         // isProduct: false,
            //         tenderName: tender.title ?? '',
            //       ));
            // } else {
            //   showShortToast('login_to_view_tender'.tr);
            // }
            if (context.read<AuthBloc>().state.isLoggedIn) {
              context.read<AuctionDetailBloc>().add(
                  GetAuctionDetail(auctionId: auction.id!, context: context));
              context.read<SimilarAuctionsBloc>().add(
                    GetSimilarAuctions(
                      auctionId: auction.id.toString(),
                      currentPage: 1,
                    ),
                  );
              Get.off(
                  () => AuctionDetailScreen(
                        auctionName: auction.title ?? '',
                        auctionId: auction.id!,
                        isSearch: isSearch,
                      ),
                  preventDuplicates: false);
            } else {
              showShortToast('login_to_view_auction'.tr);
            }
          },
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Stack(
                  children: [
                    CustomImage(
                        // image: tender.product?.image ?? '',
                        image: auction.product?.images != null &&
                                auction.product!.images!.isNotEmpty
                            ? auction.product!.images![0].small.toString()
                            : auction.product?.image ?? '',
                        height: 120,
                        width: 100,
                        radius: 16),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: CustomFavoriteButton(
                          isFavorite: false,
                          // tender.isFavorite ?? false,
                          onTap: () {
                            // context.read<SimilarTendersBloc>().add(
                            //     ToggleFavoriteSimilarTender(
                            //         tenderId: tender.id.toString(),
                            //         context: context));
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
                            auction.title ?? '',
                            // 'Садовая мебель, раскладные стулья',
                            style: h16.copyWith(color: ColorResources.darkGray),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            auction.product?.description ?? '',
                            style: body14.copyWith(color: ColorResources.gray),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'quantity'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(71, 84, 103, 1)),
                              ),
                              Expanded(
                                child: Text(
                                  '${auction.product?.quantity} шт',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: body14.copyWith(
                                      color: Color.fromRGBO(71, 84, 103, 1)),
                                ),
                              ),
                            ],
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
                          // Row(
                          //   children: [
                          //     // Text(
                          //     //   'budget'.tr,
                          //     //   overflow: TextOverflow.ellipsis,
                          //     //   maxLines: 1,
                          //     //   style: body14.copyWith(
                          //     //       fontWeight: FontWeight.w700,
                          //     //       color: Color.fromRGBO(71, 84, 103, 1)),
                          //     // ),
                          //     // Expanded(
                          //     //   child: Text(
                          //     //     '${tender.budgetFrom} - ${tender.budgetTo} ${'som'.tr}',
                          //     //     overflow: TextOverflow.ellipsis,
                          //     //     maxLines: 1,
                          //     //     style: body14.copyWith(
                          //     //         color: Color.fromRGBO(71, 84, 103, 1)),
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'legal_entity'.tr,
                      //       style: body14.copyWith(color: ColorResources.gray),
                      //     ),
                      //     Text(
                      //       formatDateInRu(tender.createdAt.toString()),
                      //       style: body14.copyWith(color: ColorResources.gray),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
