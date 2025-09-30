import 'package:el_biz/bloc/auction/auction_bid/auction_bid_bloc.dart';
import 'package:el_biz/bloc/auction/auction_buy_offer/auction_buy_offer_bloc.dart';
import 'package:el_biz/bloc/auction/auction_detail/auction_detail_bloc.dart';
import 'package:el_biz/data/model/response/auction/auction_detail_model.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// import '../../../../../bloc/auction/auctions/auctions_bloc.dart';
import '../../../../../utils/Images.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_textfield.dart';

class AddBetBottomSheet extends StatefulWidget {
  final TextEditingController suggestedBidController;
  final ValueChanged<String> onChanged;
  final AuctionDetailData auction;
  final String minimumNextBid;
  const AddBetBottomSheet({
    super.key,
    required this.suggestedBidController,
    required this.onChanged,
    required this.auction,
    required this.minimumNextBid,
  });

  @override
  State<AddBetBottomSheet> createState() => _AddBetBottomSheetState();
}

class _AddBetBottomSheetState extends State<AddBetBottomSheet> {
  @override
  void initState() {
    super.initState();
    widget.suggestedBidController.text = widget.minimumNextBid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuctionBidBloc, AuctionBidState>(
      listener: (context, state) {
        if (state is AddAuctionBidSuccess) {
          Get.back();
          //need to call the auction detail bloc to refresh the auction details
          context.read<AuctionDetailBloc>().add(GetAuctionDetail(
              auctionId: widget.auction.id!,
              context: context,
              isRefresh: false));
          Get.defaultDialog(
            title: 'you_placed_bet'.tr,
            content: Text('wait_until_auction_end'.tr,
                style: textStyle13Inter.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorResources.black,
                    fontFamily: 'SFPRO')),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            titlePadding: EdgeInsets.only(top: 16),
            radius: 16,
            titleStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'SFPRO'),
            backgroundColor: Colors.white.withOpacity(0.8),
            barrierDismissible: true,
            onWillPop: () async {
              return true;
            },
          );
        } else if (state is AddAuctionBidError) {
          showShortToast(state.message);
        }
      },
      child: BlocListener<AuctionBuyOfferBloc, AuctionBuyOfferState>(
        listener: (context, state) {
          if (state is AuctionBuyOfferSuccess) {
            Get.back();
          } else if (state is AuctionBuyOfferFailure) {
            showShortToast(state.errorMessage);
          }
        },
        child: BlocBuilder<AuctionBidBloc, AuctionBidState>(
          builder: (context, auctionsState) {
            return BlocBuilder<AuctionBuyOfferBloc, AuctionBuyOfferState>(
              builder: (context, buyOfferState) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 5,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.5),
                                color: Color.fromRGBO(60, 60, 67, 0.3)),
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       Get.back();
                          //     },
                          //     icon: Icon(Icons.close))
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(217, 217, 217, 1)),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.auction.bids != null &&
                          widget.auction.bids!.isNotEmpty)
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                              color: ColorResources.backgroundColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'last_bet'.tr,
                                style:
                                    body12.copyWith(color: ColorResources.gray),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget
                                              .auction.bids!.first.user!.name!,
                                          style: h16.copyWith(
                                              color: ColorResources.darkGray),
                                        ),
                                        Text(
                                          widget.auction.bids!.first
                                                  .timeSinceBid ??
                                              '',
                                          style: body12.copyWith(
                                              color: ColorResources.gray),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${widget.auction.higestBitPrice}\$',
                                    style: h16.copyWith(
                                        color: ColorResources.darkGray),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'your_bet'.tr,
                        style: body12.copyWith(color: ColorResources.gray),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        controller: widget.suggestedBidController,
                        hintColor: '',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'))
                        ],
                        inputType: TextInputType.number,
                        leading: '',
                        onChanged: (val) {
                          widget.onChanged(val);
                        },
                        readOnly: false,
                        suffix: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          child: Text('\$'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'Добавьте ещё 60\$ и купите не ожидая окончания аукциона',
                      //   style: body14,
                      // ),
                      if (double.parse(widget.auction.targetPrice ?? '0') >
                          double.parse(widget.auction.higestBitPrice ?? '0'))
                        RichText(
                          text: TextSpan(
                            style: body14, // Your default text style
                            children: [
                              TextSpan(text: 'add_more'.tr),
                              TextSpan(
                                text:
                                    '${double.parse(widget.auction.targetPrice ?? '0') - double.parse(widget.auction.higestBitPrice ?? '0')}\$',
                                style: body14.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: 'buy_without_waiting'.tr,
                                  style: body14),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: auctionsState is AddAuctionBidLoading ||
                                buyOfferState is AuctionBuyOfferLoading
                            ? null
                            : () {
                                if (widget
                                    .suggestedBidController.text.isEmpty) {
                                  showShortToast('enter_your_bid'.tr);
                                  return;
                                }
                                context.read<AuctionBidBloc>().add(
                                    AddAuctionBid(
                                        auctionId: widget.auction.id!,
                                        bidAmount: double.parse(widget
                                            .suggestedBidController.text)));
                              },
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: ColorResources.primary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1, color: ColorResources.blue),
                          ),
                          alignment: Alignment.center,
                          child: auctionsState is AddAuctionBidLoading
                              ? SizedBox(
                                  height: 26,
                                  width: 26,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Images.svgCurrency),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'place_bet'.tr,
                                      style: body16.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Inter'),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onTap: auctionsState is AddAuctionBidLoading ||
                                buyOfferState is AuctionBuyOfferLoading
                            ? () {}
                            : () {
                                // buy at your price
                                if (widget
                                    .suggestedBidController.text.isEmpty) {
                                  showShortToast('enter_your_price'.tr);
                                  return;
                                }
                                double offerPrice = double.parse(
                                    widget.suggestedBidController.text);
                                if (offerPrice <
                                    double.parse(
                                        widget.auction.targetPrice ?? '0')) {
                                  showShortToast(
                                      'price_must_be_equal_or_greater_than_target_price'
                                          .tr);
                                  return;
                                }
                                context.read<AuctionBuyOfferBloc>().add(
                                    SubmitAuctionBuyOfferEvent(
                                        widget.auction.id!, offerPrice));
                              },
                        width: Get.width,
                        height: 46,
                        title: buyOfferState is AuctionBuyOfferLoading
                            ? 'loading'.tr
                            : '${'buy_at_your_price'.tr} ${double.parse(widget.auction.targetPrice ?? widget.auction.buyoutPrice ?? '0')}\$',
                        color: ColorResources.blue.withOpacity(0.2),
                        textColor: ColorResources.blue,
                        radius: 16,
                      ),
                    ],
                  ).paddingOnly(
                      bottom: (MediaQuery.of(context).padding.bottom - 12)
                          .clamp(0.0, double.infinity)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
