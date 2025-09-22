import 'package:el_biz/bloc/auction/auction_detail/auction_detail_bloc.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/auction/auction_detail/widgets/add_bet_bottomsheet.dart';
import 'package:el_biz/view/screen/auction/auction_detail/widgets/leave_review_bottomsheet.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../base/custom_favorite_button.dart';
import 'widgets/auction_bets_widget.dart';
import 'widgets/auction_detail_widget.dart';
import 'widgets/similar_auctions_widget.dart';

class AuctionDetailScreen extends StatefulWidget {
  final bool isSeller;
  final String auctionName;

  const AuctionDetailScreen(
      {super.key, required this.auctionName, this.isSeller = false});

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  bool isShowDescription = true;
  // final TextEditingController lastBidController = TextEditingController();
  final TextEditingController suggestedBidController = TextEditingController();
  final TextEditingController leaveReviewController = TextEditingController();
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
      body: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
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
          final auction = productDetialController.auctionDetailModel.data;
          if (auction == null) {
            return SizedBox();
          }
          print('this is the location = ${auction.location}');
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ProductImages(
                    image: const [],
                    isProductDetail: true,
                    productDetailImages: auction.product?.images ?? [],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (auction.freeShipping == true)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: ColorResources.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'free_delivery'.tr,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.white,
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
                                            auction.location ?? '',
                                            // 'bishkek'.tr,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorResources.gray,
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        auction.title ??
                                            auction.product?.name ??
                                            '',
                                        // 'Silvie Mahdal art',
                                        style: h24.copyWith(
                                            color: ColorResources.darkGray),
                                      ),
                                      Text(
                                        // 'painting_and_graphics'.tr,
                                        auction.product?.description ?? '',
                                        style: body16.copyWith(
                                            color: ColorResources.gray),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomFavoriteButton(
                                  isFavorite: false,
                                  // tenderDetail.data?.isFavorite ?? false,
                                  onTap: () {
                                    // context.read<TenderDetailBloc>().add(
                                    //     ToggleTenderDetailFavorite(
                                    //         tenderId: tenderDetail.data!.id!,
                                    //         context: context));
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
                                  '${auction.productPrice}\$',
                                  style:
                                      h16.copyWith(color: ColorResources.blue),
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
                                  '${auction.buyoutPrice}\$',
                                  style:
                                      h16.copyWith(color: ColorResources.blue),
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
                                          style: textStyle13Inter.copyWith(
                                              color: isShowDescription
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.8)),
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
                                          style: textStyle13Inter.copyWith(
                                              color: isShowDescription
                                                  ? Colors.black
                                                      .withOpacity(0.8)
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
                          ? AuctionDetailWidget()
                          : AuctionBetsWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // winner leave comment
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      LeaveReviewBottomsheet(
                        leaveReviewController: leaveReviewController,
                        onChanged: (val) {
                          setState(() {});
                        },
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
                                color: ColorResources.darkGray, fontSize: 15)),
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
                                width: 1, color: ColorResources.lgColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            leaveReviewController.text.isEmpty
                                ? 'write_something_nice'.tr
                                : leaveReviewController.text,
                            style: body16.copyWith(
                                color:
                                    ColorResources.darkGray.withOpacity(0.3)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // feedback on auction
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                              color: ColorResources.darkGray, fontSize: 15)),
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
                            // tenderDetail.data!.company?.name ?? '',
                            'Тансулуу Р.',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          subtitle: Text(
                            // tenderDetail.data!.company?.owner?.name ?? '',
                            'Получила! Все отлично!🥰 ',
                            style:
                                body14.copyWith(color: ColorResources.darkGray),
                          ),
                          trailing: SizedBox(
                            // width: 100,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: ColorResources.orange,
                                borderRadius: BorderRadius.circular(20),
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
                const SizedBox(
                  height: 20,
                ),

                // salesman for the auction
                GestureDetector(
                  onTap: () {
                    // if (tenderDetail.data?.company != null) {
                    //   context.read<CompanyDetailBloc>().add(GetCompanyDetail(
                    //       tenderDetail.data!.company!.id.toString()));
                    //   context.read<SimilarCompaniesBloc>().add(
                    //       GetSimilarCompanies(
                    //           companyId:
                    //               tenderDetail.data!.company!.id.toString(),
                    //           currentPage: 1));
                    //   Get.to(() => CompanyPageScreen());
                    // }
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
                                width: 1, color: ColorResources.lgColor),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.all(0),
                            leading: CustomImage(
                                image: '',
                                // tenderDetail.data!.company?.logo ?? '',
                                height: 40,
                                width: 40,
                                radius: 40),
                            title: Text(
                              // tenderDetail.data!.company?.name ?? '',
                              'Садовая мебель Loft',
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            subtitle: Text(
                              // tenderDetail.data!.company?.owner?.name ?? '',
                              'ОсОО...',
                              style: body14.copyWith(
                                  color: ColorResources.darkGray),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // if (tenderDetail.data!.company?.verificationStatus ==
                        //     'verified')
                        Row(
                          children: [
                            SvgPicture.asset(Images.svgVerified),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'verified_supplier'.tr,
                                style:
                                    body14.copyWith(color: ColorResources.gray),
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
                  tenderId: '',
                  // tenderId: tenderDetail.data!.id.toString(),
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
      bottomNavigationBar: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
        builder: (context, state) {
          if (state is AuctionDetailSuccess) {
            final auction = state.auctionDetailModel.data;
            // setState(() {});
            if (auction == null) {
              return SizedBox();
            }
            return BottomAppBar(
              height: widget.isSeller ? 75 : 150,
              color: Colors.white,
              child: widget.isSeller
                  ? CustomBorderButton(
                      height: 47,
                      width: Get.width,
                      padding: EdgeInsets.all(0),
                      border:
                          Border.all(width: 1, color: ColorResources.orange),
                      borderRadius: BorderRadius.circular(12),
                      boxShaow: [],
                      child: Text(
                        'withdraw_auction'.tr,
                        style: h16.copyWith(
                            color: ColorResources.orange,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                      onTap: () {
                        print('pressed');

                        Get.dialog(
                          CupertinoAlertDialog(
                            title: Text('confirmed_withdraw_auction'.tr),
                            content: Text('buyers_no_longer_bet'.tr),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text('yes'.tr),
                                  onPressed: () {
                                    Get.back();
                                  }),
                              CupertinoDialogAction(
                                  child: Text('cancel'.tr),
                                  onPressed: () {
                                    Get.back();
                                  }),
                            ],
                          ),
                        );
                      })

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
                                      '${auction.higestBitPrice}\$',
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
                                  // CustomTextField(
                                  //     controller: suggestedBidController,
                                  //     hintColor: '',
                                  //     inputType: TextInputType.number,
                                  //     leading: '',

                                  //     readOnly: false),
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: ColorResources.lgColor),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${suggestedBidController.text}\$',
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
                        // CustomButton(width: Get.width, height: 44, onTap: () {}, title: ''),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              AddBetBottomSheet(
                                suggestedBidController: suggestedBidController,
                                onChanged: (val) {
                                  setState(() {});
                                },
                                auction: auction,
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
