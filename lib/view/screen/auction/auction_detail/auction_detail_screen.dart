import 'package:el_biz/bloc/auction/auction_bids_list/auction_bids_list_bloc.dart';
import 'package:el_biz/bloc/auction/auction_cancel/auction_cancel_bloc.dart';
import 'package:el_biz/bloc/auction/auction_detail/auction_detail_bloc.dart';
import 'package:el_biz/bloc/auction/favorite_auciton/favorite_auction_bloc.dart';
import 'package:el_biz/bloc/auction/search_auction/search_auction_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/auction/auction_detail_model.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/auction/auction_detail/widgets/add_bet_bottomsheet.dart';
import 'package:el_biz/view/screen/auction/auction_detail/widgets/leave_review_bottomsheet.dart';
import 'package:el_biz/view/screen/auction/auction_detail/widgets/show_buy_offers_widget.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/auction/auction_buy_offer/auction_buy_offer_bloc.dart';
import '../../../../bloc/auction/auctions/auctions_bloc.dart';
import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../../data/model/response/auction/get_buy_offer_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../base/custom_favorite_button.dart';
import '../../company/company_page_screen.dart';
import 'widgets/auction_bets_widget.dart';
import 'widgets/auction_detail_widget.dart';
import 'widgets/similar_auctions_widget.dart';

class AuctionDetailScreen extends StatefulWidget {
  final String auctionName;
  final int auctionId;
  final bool isSearch;

  const AuctionDetailScreen({
    super.key,
    required this.auctionName,
    required this.auctionId,
    required this.isSearch,
  });

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  bool isShowDescription = true;
  // final TextEditingController lastBidController = TextEditingController();
  final TextEditingController suggestedBidController = TextEditingController();
  final TextEditingController leaveReviewController = TextEditingController();
  List<BuyOfferData> buyOffers = [];
  AuctionDetailData? auction;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      context.read<AuctionBuyOfferBloc>().add(GetBuyOffersEvent(auction!.id!));
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.auctionName),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.primary,
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
            child: SvgPicture.asset(Images.svgAlert),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(Duration.zero, () {
            context.read<AuctionDetailBloc>().add(GetAuctionDetail(
                auctionId: widget.auctionId, context: context));

            context
                .read<AuctionBidsListBloc>()
                .add(GetAuctionBids(auctionId: widget.auctionId));
          });
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<FavoriteAuctionBloc, FavoriteAuctionState>(
              listener: (context, state) {
                if (state is AuctionDetailFavoriteSuccess) {
                  print(
                      'going to call the update function in auctions list with //${auction?.isFavorite}');
                  context.read<AuctionsBloc>().add(UpdateAuctionInFavoriteList(
                      auctionId: auction!.id!,
                      isFavorite: auction?.isFavorite ?? false));

                  if (widget.isSearch) {
                    context.read<SearchAuctionBloc>().add(
                        UpdateSearchAuctionInFavoriteList(
                            auctionId: auction!.id!,
                            isFavorite: auction?.isFavorite ?? false));
                  }
                }
              },
            ),
            // BlocListener<SubjectBloc, SubjectState>(
            //     listener: (context, state) {
            //         // TODO: implement listener
            //     },
            // ),
            BlocListener<AuctionBuyOfferBloc, AuctionBuyOfferState>(
              // listenWhen: (previous, current) =>
              //     current is AuctionGetBuyOffersLoaded,
              listener: (context, offerState) {
                // log('im the creator of this auciton and there are buy offers with auction id = ${auction?.creator?.id} and user id = ${context.read<UserBloc>().state.userInfo?.data?.id}');
                if (offerState is AuctionGetBuyOffersLoaded) {
                  if (auction?.creator?.id ==
                          context.read<UserBloc>().state.userInfo?.data?.id &&
                      auction?.status == 'open') {
                    if (offerState.buyOffers.isNotEmpty) {
                      setState(() {
                        buyOffers = offerState.buyOffers;
                      });
                      Get.dialog(CupertinoAlertDialog(
                        title: Text(
                            "${'your_target_price'.tr} ${offerState.buyOffers.first.offerPrice} ${'has_been_offered'.tr}"),
                        content: Text(
                            'do_you_want_to_cancel_the_auction_or_continue'.tr),
                        actions: [
                          BlocBuilder<AuctionCancelBloc, AuctionCancelState>(
                            builder: (context, auctionCancel) {
                              return CupertinoDialogAction(
                                  child: auctionCancel is CancelAuctionLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text('stop'.tr),
                                  onPressed: () {
                                    Get.back();
                                    Get.dialog(
                                      CustomDialog(
                                        widget: ShowBuyOffersWidget(
                                          offers: offerState.buyOffers,
                                        ),
                                      ),
                                    );
                                    // context.read<AuctionCancelBloc>().add(
                                    //     CancelAuction(auctionId: auction!.id!));
                                  });
                            },
                          ),
                          CupertinoDialogAction(
                              child: Text('continue'.tr),
                              onPressed: () {
                                Get.back();
                              }),
                        ],
                      ));
                    }
                  }
                }
                if (offerState is AuctionRespondToBuyOfferSuccess) {
                  showShortToast(offerState.message);
                  context.read<AuctionDetailBloc>().add(GetAuctionDetail(
                      auctionId: auction!.id!, context: context));

                  context.read<AuctionsBloc>().add(GetMyAuctions(page: 1));
                  context.read<AuctionsBloc>().add(GetAuctions(page: 1));
                }
                if (offerState is AuctionResponsdToBuyOfferFailure) {
                  showShortToast(offerState.errorMessage);
                }
              },
            ),
          ],
          child: BlocConsumer<AuctionDetailBloc, AuctionDetailState>(
              listenWhen: (previous, current) =>
                  current is AuctionDetailSuccess,
              listener: (context, state) {
                // if (state is AuctionDetailSuccess) {
                //   if (auction?.creator?.id != null &&
                //       auction?.creator?.id ==
                //           context.read<UserBloc>().state.userInfo?.data?.id &&
                //       auction?.status == 'open') {
                //     Get.dialog(
                //       CupertinoAlertDialog(
                //         title: Text(
                //             "${'your_target_price'.tr} ${state.auctionDetailModel.data?.targetPrice ?? state.auctionDetailModel.data?.buyoutPrice} ${'has_been_offered'.tr}"),
                //         content:
                //             Text('do_you_want_to_cancel_the_auction_or_continue'.tr),
                //         actions: [
                //           BlocBuilder<AuctionCancelBloc, AuctionCancelState>(
                //             builder: (context, auctionCancel) {
                //               return CupertinoDialogAction(
                //                   child: auctionCancel is CancelAuctionLoading
                //                       ? SizedBox(
                //                           height: 20,
                //                           width: 20,
                //                           child: CircularProgressIndicator(
                //                             color: Colors.black,
                //                           ),
                //                         )
                //                       : Text('stop'.tr),
                //                   onPressed: () {
                //                     // Get.back();
                //                     context
                //                         .read<AuctionCancelBloc>()
                //                         .add(CancelAuction(auctionId: auction!.id!));
                //                   });
                //             },
                //           ),
                //           CupertinoDialogAction(
                //               child: Text('continue'.tr),
                //               onPressed: () {
                //                 Get.back();
                //               }),
                //         ],
                //       ),
                //     );
                //   }
                // }
              },
              builder: (context, productDetialController) {
                if (productDetialController is AuctionDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (productDetialController is AuctionDetailError) {
                  return Center(
                    child: Text('error'.tr),
                  );
                }
                if (productDetialController is AuctionDetailSuccess) {
                  final auctionModel =
                      productDetialController.auctionDetailModel;
                  auction = auctionModel.data;
                  if (auction == null) {
                    return SizedBox();
                  }

                  // print('this is the location = ${auction.location}');
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ProductImages(
                            image: const [],
                            isProductDetail: true,
                            productDetailImages: auction?.product?.images ?? [],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: -2,
                                offset: Offset(0, 2),
                                color: Color.fromRGBO(16, 24, 40, 0.06),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (auction?.freeShipping == true)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: ColorResources.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    'free_delivery'.tr,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ColorResources.white,
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.location_on),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    auction?.location ?? '',
                                                    // 'bishkek'.tr,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            ColorResources.gray,
                                                        fontFamily: 'Inter'),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                auction?.title ??
                                                    auction?.product?.name ??
                                                    '',
                                                // 'Silvie Mahdal art',
                                                style: h24.copyWith(
                                                    color: ColorResources
                                                        .darkGray),
                                              ),
                                              Text(
                                                // 'painting_and_graphics'.tr,
                                                // auction?.product?.description ?? '',
                                                auction?.product?.brand ?? '',
                                                style: body16.copyWith(
                                                    color: ColorResources.gray),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomFavoriteButton(
                                          isFavorite:
                                              auction?.isFavorite ?? false,
                                          onTap: () {
                                            context
                                                .read<FavoriteAuctionBloc>()
                                                .add(
                                                    ToggleAuctionDetailFavorite(
                                                        auctionId:
                                                            auction!.id!));

                                            setState(() {
                                              auction!.isFavorite =
                                                  !auction!.isFavorite!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'own_price'.tr,
                                          style: textStyle13Inter,
                                        ),
                                        Text(
                                          '${auction?.productPrice} ${AppConstants.currencyCode}',
                                          style: h16.copyWith(
                                              color: ColorResources.blue),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'price_with_last_bet'.tr,
                                          style: textStyle13Inter,
                                        ),
                                        Text(
                                          '${auction?.buyoutPrice} ${AppConstants.currencyCode}',
                                          style: h16.copyWith(
                                              color: ColorResources.blue),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 32,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(232, 232, 237, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          // description
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isShowDescription = true;
                                                });
                                              },
                                              child: Container(
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  color: isShowDescription
                                                      ? Colors.white
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'description'.tr,
                                                  style:
                                                      textStyle13Inter.copyWith(
                                                          color: isShowDescription
                                                              ? Colors.black
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.8)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // bets
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isShowDescription = false;
                                                });
                                              },
                                              child: Container(
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  color: isShowDescription
                                                      ? null
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'bets'.tr,
                                                  style:
                                                      textStyle13Inter.copyWith(
                                                          color: isShowDescription
                                                              ? Colors.black
                                                                  .withOpacity(
                                                                      0.8)
                                                              : Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ],
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              isShowDescription
                                  ? AuctionDetailWidget(
                                      auction: auction!,
                                    )
                                  : AuctionBetsWidget(
                                      auction: auction!,
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (auction!.winner != null &&
                                  auction!.winner!.type == 'buy_offer')
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: ColorResources.orange,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'winner_buy_offer'.tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: body14.copyWith(
                                                color: ColorResources.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${auction!.winner?.name}',
                                          style: body14.copyWith(
                                              color: ColorResources.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // winner leave comment
                        // if (auctionModel.isWinner == true) ...[
                        if (auction!.winner != null &&
                            auction!.winner!.id ==
                                context
                                    .read<UserBloc>()
                                    .state
                                    .userInfo
                                    ?.data
                                    ?.id &&
                            (auction?.reviews == null ||
                                auction!.reviews!.isEmpty)) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                LeaveReviewBottomsheet(
                                  leaveReviewController: leaveReviewController,
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  auctionId: auction!.id!,
                                ),
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              // width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: -2,
                                    offset: Offset(0, 2),
                                    color: Color.fromRGBO(16, 24, 40, 0.06),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('leave_review'.tr,
                                      style: h16.copyWith(
                                          color: ColorResources.darkGray,
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      border: Border.all(
                                          width: 1,
                                          color: ColorResources.lgColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      leaveReviewController.text.isEmpty
                                          ? 'write_something_nice'.tr
                                          : leaveReviewController.text,
                                      style: body16.copyWith(
                                          color: ColorResources.darkGray
                                              .withOpacity(0.3)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        // there have to show the winners review about this auction
                        if (auction?.reviews != null &&
                            auction!.reviews!.isNotEmpty) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          // feedback on auction //  if auction.reviews. is not empty then need to show this
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: -2,
                                  offset: Offset(0, 2),
                                  color: Color.fromRGBO(16, 24, 40, 0.06),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('auction_review'.tr,
                                    style: h16.copyWith(
                                        color: ColorResources.darkGray,
                                        fontSize: 15)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: ColorResources.lightBlue,
                                    borderRadius: BorderRadius.circular(16),
                                    //   border:
                                    //       Border.all(width: 1, color: ColorResources.lgColor),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      auction!.reviews!.first.user?.name ?? '',
                                      style: h16.copyWith(
                                          color: ColorResources.darkGray),
                                    ),
                                    subtitle: Text(
                                      // tenderDetail.data!.company?.owner?.name ?? '',
                                      auction!.reviews!.first.comment ?? '',
                                      // 'Получила! Все отлично!🥰 ',
                                      style: body14.copyWith(
                                          color: ColorResources.darkGray),
                                    ),
                                    trailing: SizedBox(
                                      // width: 100,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: ColorResources.orange,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'winner'.tr,
                                          style: body14.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),

                        // salesman for the auction
                        GestureDetector(
                          onTap: () {
                            if (auction?.product?.company != null) {
                              context.read<CompanyDetailBloc>().add(
                                  GetCompanyDetail(auction!.product!.company!.id
                                      .toString()));
                              context.read<SimilarCompaniesBloc>().add(
                                  GetSimilarCompanies(
                                      companyId: auction!.product!.company!.id
                                          .toString(),
                                      currentPage: 1));
                              Get.to(() => CompanyPageScreen());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: -2,
                                  offset: Offset(0, 2),
                                  color: Color.fromRGBO(16, 24, 40, 0.06),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('seller'.tr,
                                    style: h16.copyWith(
                                      color: ColorResources.darkGray,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: ColorResources.lightBlue,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 1,
                                        color: ColorResources.lgColor),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomImage(
                                        image:
                                            auction!.product!.company?.logo ??
                                                '',
                                        height: 40,
                                        width: 40,
                                        radius: 40),
                                    title: Text(
                                      auction!.company?.name ?? '',
                                      style: h16.copyWith(
                                          color: ColorResources.darkGray),
                                    ),
                                    subtitle: Text(
                                      auction!.product!.company?.email ?? '',
                                      // 'ОсОО...',
                                      style: body14.copyWith(
                                          color: ColorResources.darkGray),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (auction!
                                        .product!.company?.verificationStatus ==
                                    'verified')
                                  Row(
                                    children: [
                                      SvgPicture.asset(Images.svgVerified),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'verified_supplier'.tr,
                                          style: body14.copyWith(
                                              color: ColorResources.gray),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SimilarAuctionWidget(
                          auctionId: auction!.id!,
                          auctionName: auction!.title ?? '',
                          isSearch: widget.isSearch,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
                // if (productDetialController.tenderDetailModel?.data == null) {
                // }
                // var tenderDetail = productDetialController.tenderDetailModel!;

                // print(
                // 'this is the favorite option in tender detail = ${tenderDetail.data?.isFavorite ?? false}');
              }),
        ),
      ),
      bottomNavigationBar: BlocListener<AuctionCancelBloc, AuctionCancelState>(
        listener: (context, cancelState) {
          if (cancelState is CancelAuctionSuccess) {
            Get.back();
            // context.read<AuctionsBloc>().add(GetAuctions(page: 1));
            // Get.back();
            // context
            //     .read<AuctionDetailBloc>()
            //     .add(UpdateAuctionStatus(status: 'cancelled'));
            context.read<AuctionDetailBloc>().add(GetAuctionDetail(
                auctionId: widget.auctionId, context: context));
          }
          if (cancelState is CancelAuctionError) {
            Get.back();
            showShortToast(cancelState.message);
          }
          if (cancelState is PublishCanceledAuctionSuccess) {
            Get.back();
            // context
            //     .read<AuctionDetailBloc>()
            //     .add(UpdateAuctionStatus(status: 'draft'));
            context.read<AuctionDetailBloc>().add(GetAuctionDetail(
                auctionId: widget.auctionId, context: context));
          }
          if (cancelState is PublishCanceledAuctionError) {
            Get.back();
            showShortToast(cancelState.message);
          }
        },
        child: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
          builder: (context, state) {
            if (state is AuctionDetailSuccess) {
              final auctionModel = state.auctionDetailModel;
              final auction = auctionModel.data;

              if (auction == null) {
                return SizedBox();
              }

              if (auction.timeRemaining == 'Ended') {
                return SizedBox.shrink();
              }
              bool isSeller = auction.creator?.id ==
                  context.read<UserBloc>().state.userInfo?.data?.id;
              return BottomAppBar(
                height: isSeller
                    ? (auction.status == 'open' && auction.bidCount == 0)
                        ? 75
                        : 127
                    : 150,
                color: Colors.white,
                child: isSeller
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // CustomBorderButton(height: 47, width: Get.width, padding: EdgeInsets.all(0), border: border, borderRadius: borderRadius, boxShaow: boxShaow, child: child, onTap: onTap)
                          if (auction.status == 'open' &&
                              auction.bidCount == 0) ...[
                            SizedBox(),
                          ] else ...[
                            CustomButton(
                                width: Get.width,
                                height: 47,
                                onTap: () {
                                  auction.status == 'open'
                                      ? Get.dialog(
                                          CupertinoAlertDialog(
                                            title: Text(
                                                'are_you_sure_to_close_auction'
                                                    .tr),
                                            content: Text(
                                                'as_auction_will_close_it_will_assign_to_higher_bid'
                                                    .tr),
                                            actions: [
                                              CupertinoDialogAction(
                                                  child: Text('yes'.tr),
                                                  onPressed: () {
                                                    Get.back();

                                                    context
                                                        .read<
                                                            AuctionDetailBloc>()
                                                        .add(AuctionBidClosed(
                                                            auctionId:
                                                                auction.id!,
                                                            context: context));
                                                  }),
                                              CupertinoDialogAction(
                                                  child: Text('cancel'.tr),
                                                  onPressed: () {
                                                    Get.back();
                                                  }),
                                            ],
                                          ),
                                        )
                                      // context.read<AuctionDetailBloc>().add(
                                      //     AuctionBidClosed(
                                      //         auctionId: auction.id!,
                                      //         context: context))
                                      : context
                                          .read<AuctionDetailBloc>()
                                          .add(AuctionBidOpen(
                                            auctionId: auction.id!,
                                            context: context,
                                          ));
                                },
                                title: auction.status == 'open'
                                    ? 'close_auction'.tr
                                    : 'open_auction'),
                            const SizedBox(
                              height: 8,
                            ),
                          ],

                          CustomBorderButton(
                              height: 47,
                              width: Get.width,
                              padding: EdgeInsets.all(0),
                              border: Border.all(
                                  width: 1, color: ColorResources.orange),
                              borderRadius: BorderRadius.circular(12),
                              boxShaow: [],
                              child: Text(
                                auction.status == 'cancelled'
                                    ? "publish_auction".tr
                                    : 'withdraw_auction'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.orange,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                              onTap: () {
                                print('pressed');
                                auction.status == 'cancelled'
                                    ? {
                                        // add publish auction event

                                        Get.dialog(
                                          CupertinoAlertDialog(
                                            title: Text(
                                                'are_you_sure_to_publish_again'
                                                    .tr),
                                            // content: Text('buyers_no_longer_bet'.tr),
                                            actions: [
                                              BlocBuilder<AuctionCancelBloc,
                                                  AuctionCancelState>(
                                                builder:
                                                    (context, auctionCancel) {
                                                  return CupertinoDialogAction(
                                                      child: auctionCancel
                                                              is PublishCanceledAuctionLoading
                                                          ? SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : Text('yes'.tr),
                                                      onPressed: () {
                                                        // Get.back();
                                                        context
                                                            .read<
                                                                AuctionCancelBloc>()
                                                            .add(PublishCanceledAuction(
                                                                auctionId:
                                                                    auction
                                                                        .id!));
                                                      });
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text('cancel'.tr),
                                                  onPressed: () {
                                                    Get.back();
                                                  }),
                                            ],
                                          ),
                                        ),
                                      }
                                    : {
                                        Get.dialog(
                                          CupertinoAlertDialog(
                                            title: Text(
                                                'confirmed_withdraw_auction'
                                                    .tr),
                                            content:
                                                Text('buyers_no_longer_bet'.tr),
                                            actions: [
                                              BlocBuilder<AuctionCancelBloc,
                                                  AuctionCancelState>(
                                                builder:
                                                    (context, auctionCancel) {
                                                  return CupertinoDialogAction(
                                                      child: auctionCancel
                                                              is CancelAuctionLoading
                                                          ? SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : Text('yes'.tr),
                                                      onPressed: () {
                                                        // Get.back();
                                                        context
                                                            .read<
                                                                AuctionCancelBloc>()
                                                            .add(CancelAuction(
                                                                auctionId:
                                                                    auction
                                                                        .id!));
                                                      });
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                  child: Text('cancel'.tr),
                                                  onPressed: () {
                                                    Get.back();
                                                  }),
                                            ],
                                          ),
                                        ),
                                      };
                              }),
                        ],
                      )

                    // Container(
                    //     height: 46,
                    //     decoration: BoxDecoration(
                    //       color: ColorResources.primary,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 110,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'last_bet'.tr,
                                      style: body12.copyWith(
                                          color: ColorResources.gray),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        // '500\$',
                                        '${auction.higestBitPrice}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.darkGray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'your_bet'.tr,
                                      style: body12.copyWith(
                                          color: ColorResources.gray),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          AddBetBottomSheet(
                                            suggestedBidController:
                                                suggestedBidController,
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                            auction: auction,
                                            minimumNextBid:
                                                suggestedBidController
                                                        .text.isEmpty
                                                    ? auctionModel
                                                        .minimumNextBid
                                                        .toString()
                                                    : suggestedBidController
                                                        .text,
                                          ),
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 46,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: ColorResources.lgColor),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${suggestedBidController.text == "" ? auctionModel.minimumNextBid : suggestedBidController.text} ${AppConstants.currencyCode}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: ColorResources.darkGray,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                AddBetBottomSheet(
                                  suggestedBidController:
                                      suggestedBidController,
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  auction: auction,
                                  minimumNextBid: suggestedBidController
                                          .text.isEmpty
                                      ? auctionModel.minimumNextBid.toString()
                                      : suggestedBidController.text,
                                ),
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              );
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
                              child: Row(
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
                        ],
                      ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget productInfoWidget(
      {String? title,
      String? value,
      bool titleBold = false,
      bool valueBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        children: [
          Text(
            title ?? '',
            style: body14.copyWith(
              color: titleBold ? ColorResources.darkGray : ColorResources.gray,
              fontWeight: titleBold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: body14.copyWith(
                color:
                    titleBold ? ColorResources.darkGray : ColorResources.gray,
                fontWeight: valueBold ? FontWeight.w700 : FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
