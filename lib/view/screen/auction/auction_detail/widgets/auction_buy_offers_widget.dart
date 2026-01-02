import 'package:el_biz/data/model/response/auction/auction_detail_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../bloc/auction/auction_bid/auction_bid_bloc.dart';
import '../../../../../bloc/auction/auction_bids_list/auction_bids_list_bloc.dart';
import '../../../../../utils/Images.dart';
import '../../../../../utils/appConstant.dart';
import '../../../../../utils/custom_text_style.dart';

class AuctionBuyOffersWidget extends StatelessWidget {
  final AuctionDetailData auction;
  const AuctionBuyOffersWidget({super.key, required this.auction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: ColorResources.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'until_completion'.tr,
                  style: textStyle13Inter,
                ),
                Text(
                  // '6${'days'.tr} : 20${'hours'.tr} : 45${'minutes'.tr}',
                  auction.timeRemaining ?? '',
                  style: body16.copyWith(
                      color: ColorResources.darkGray, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'buy_offers'.tr,
                style: h16.copyWith(
                    color: ColorResources.darkGray, fontFamily: 'Inter'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Images.svgCurrency,
                    color: ColorResources.gray,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${auction.bidCount} ${'bets'.tr.toLowerCase()}',
                    style:
                        textStyle14Inter.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    Images.svgPersons,
                    color: ColorResources.gray,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${auction.participantCount} ${'participants'.tr}',
                    style:
                        textStyle14Inter.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<AuctionBidsListBloc, AuctionBidsListState>(
          builder: (context, state) {
            print(
                'this is the auctions bids list = ${state.auctionBids} and is loading = ${state.isLoading}');
            if (state.auctionBids.isEmpty) {
              return SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'no_bets_yet'.tr,
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                  ));
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.auctionBids.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: ColorResources.dividerColor,
                );
              },
              itemBuilder: (context, index) {
                final bidItem = state.auctionBids[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? ColorResources.white
                        : ColorResources.backgroundColor,
                  ),
                  child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorResources.darkGray,
                        ),
                      ),
                      title: Text(
                        bidItem.user?.name ?? '',
                        // 'Нур И.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorResources.darkGray,
                        ),
                      ),
                      subtitle: Text(
                        bidItem.timeSinceBid ?? '',
                        // '18.07.2025 / 20:00',
                        style: body12.copyWith(
                            color: ColorResources.gray,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter'),
                      ),
                      trailing:
                          // if my own bet then i can cancel it
                          // index == 0
                          //     ?
                          SizedBox(
                        width: Get.width * 0.4,
                        child: Row(
                          children: [
                            // my last bet then show this buttion
                            if (bidItem.isCancellable == true)
                              BlocBuilder<AuctionBidBloc, AuctionBidState>(
                                builder: (context, acuctionBidState) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      if (acuctionBidState
                                          is! CancelAuctionBidLoading) {
                                        context.read<AuctionBidBloc>().add(
                                            CancelAuctionBid(
                                                auctionId: auction.id ?? 0,
                                                bidId: bidItem.id ?? 0,
                                                context: context));
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: ColorResources.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: acuctionBidState
                                              is CancelAuctionBidLoading
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              child: SizedBox(
                                                width: 16,
                                                height: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: ColorResources.white,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'cancel_bid'.tr, // cancel bid
                                              style: body14.copyWith(
                                                  color: ColorResources.white),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            // if i win this auction then show this button on my bet 1
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8, vertical: 4),
                            //   decoration: BoxDecoration(
                            //     color: ColorResources.orange,
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            //   child: Text(
                            //     'winner'.tr,
                            //     style: body14.copyWith(
                            //         color: ColorResources.white),
                            //   ),
                            // ),

                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${bidItem.totalPrice} ${AppConstants.currencyCode}',

                                  /// '100\$',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.darkGray,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${bidItem.percentageIncrease}% ",
                                      style: body12.copyWith(
                                          color: ColorResources.gray,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter'),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    SvgPicture.asset(Images.svgTrendUp),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      // : Text(
                      //     bidItem.totalPrice ?? '',
                      //     // '100\$',
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w600,
                      //       color: ColorResources.darkGray,
                      //     ),
                      //   ),
                      ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
