import 'package:el_biz/bloc/auction/auction_detail/auction_detail_bloc.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/auction/auction_review/auction_review_bloc.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_textfield.dart';

class LeaveReviewBottomsheet extends StatelessWidget {
  final TextEditingController leaveReviewController;
  final ValueChanged<String> onChanged;
  final int auctionId;
  const LeaveReviewBottomsheet(
      {super.key,
      required this.leaveReviewController,
      required this.onChanged,
      required this.auctionId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuctionReviewBloc, AuctionReviewState>(
      listener: (context, state) {
        // if(state is AuctionReviewSuccess){
        if (state is AddAuctionReviewSuccess) {
          Get.back();
          context
              .read<AuctionDetailBloc>()
              .add(GetAuctionDetail(auctionId: auctionId, context: context));
        } else if (state is AddAuctionReviewError) {
          showShortToast(state.message);
        }
      },
      child: BlocBuilder<AuctionReviewBloc, AuctionReviewState>(
        builder: (context, auctionReviewState) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment:
                  //     CrossAxisAlignment.start,
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
                Text(
                  'leave_review'.tr,
                  style: h16.copyWith(
                    color: ColorResources.darkGray,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: leaveReviewController,
                    hintColor: '',
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                    // ],
                    inputType: TextInputType.number,
                    leading: '',
                    onChanged: (val) {
                      // setState(() {});
                      onChanged(val);
                    },
                    readOnly: false),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (auctionReviewState is! AddAuctionReviewLoading &&
                        leaveReviewController.text.isNotEmpty) {
                      context.read<AuctionReviewBloc>().add(AddAuctionReview(
                          auctionId: auctionId,
                          review: leaveReviewController.text));
                    }
                  },
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: ColorResources.primary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: ColorResources.blue),
                    ),
                    alignment: Alignment.center,
                    child: auctionReviewState is AddAuctionReviewLoading
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'send'.tr,
                                style: body16.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // CustomButton(
                //   onTap: () {},
                //   width: Get.width,
                //   height: 46,
                //   title: 'Купить за свою цену 560\$',
                //   color: ColorResources.blue.withOpacity(0.2),
                //   textColor: ColorResources.blue,
                //   radius: 16,
                // ),
              ],
            ).paddingOnly(
                bottom: (MediaQuery.of(context).padding.bottom - 12)
                    .clamp(0.0, double.infinity)),
          );
        },
      ),
    );
  }
}
