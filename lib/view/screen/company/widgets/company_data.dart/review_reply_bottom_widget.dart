import 'package:el_biz/bloc/product_review/product_review_bloc.dart';
import 'package:el_biz/data/model/response/product/product_review_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../data/model/response/company/company_reviews_model.dart';

class ReviewReplyBottomWidget extends StatefulWidget {
  final ReviewItem review;
  final int reviewIndex;
  final ProductReviewItem? productReview;
  final bool isProduct;
  const ReviewReplyBottomWidget(
      {super.key,
      required this.review,
      required this.reviewIndex,
      this.productReview,
      this.isProduct = false});

  @override
  State<ReviewReplyBottomWidget> createState() =>
      _ReviewReplyBottomWidgetState();
}

class _ReviewReplyBottomWidgetState extends State<ReviewReplyBottomWidget> {
  final TextEditingController replyController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isActiveSendButton = false;

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    replyController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              // height: 40,
              constraints: BoxConstraints(maxHeight: 100),
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.zero),
              child: TextFormField(
                controller: replyController,
                focusNode: focusNode,
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  // isDense: true,
                  // isCollapsed: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: const OutlineInputBorder(),
                  suffixIcon: InkWell(
                    onTap: () {
                      if (isActiveSendButton) {
                        if (widget.isProduct) {
                          print(
                              'this is data sending ${widget.productReview!.id} ');
                          context.read<ProductReviewBloc>().add(
                              AddProductReviewReply(
                                  widget.productReview!.id.toString(),
                                  replyController.text.trim(),
                                  widget.reviewIndex));
                        } else {
                          context.read<CompanyDetailBloc>().add(
                              AddCompanyReviewReply(
                                  widget.review.id.toString(),
                                  replyController.text.trim(),
                                  widget.reviewIndex));
                        }
                      }
                      replyController.clear();
                      focusNode.unfocus();
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: isActiveSendButton
                            ? ColorResources.blue
                            : ColorResources.greyLight,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Images.svgSendArrow),
                    ),
                  ),
                ),
                onChanged: (val) {
                  if (val.isEmpty) {
                    setState(() {
                      isActiveSendButton = false;
                    });
                  } else if (val.length == 1) {
                    setState(() {
                      isActiveSendButton = true;
                    });
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
