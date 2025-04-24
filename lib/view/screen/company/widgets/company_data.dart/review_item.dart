import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_reply_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../data/model/response/company/company_reviews_model.dart';
import '../../../../../utils/Images.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_image.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviewItem? review;
  final int? reviewIndex;
  const ReviewItemWidget({super.key, this.review, this.reviewIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                review?.user?.name ?? '',
                // 'Садовая мебель Loft',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '(5)',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
                RatingBar.builder(
                  initialRating: review?.rating?.toDouble() ?? 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 14,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: ColorResources.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                // IconButton(
                //   padding: const EdgeInsets.all(0),

                //   onPressed: () {},
                //   icon: Icon(Icons.more_vert),
                // ),
                InkWell(
                    onTap: () {
                      Get.dialog(
                        SimpleDialog(
                          backgroundColor: ColorResources.white,
                          children: [
                            ListTile(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'complain'.tr,
                                style: textMd.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'complain_about_reply'.tr,
                                style: textMd.copyWith(
                                    color: ColorResources.titleColor),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                context.read<CompanyDetailBloc>().add(
                                    DeleteCompanyReview(
                                        review?.id.toString() ?? ''));
                                Get.back();
                              },
                              title: Text(
                                'delete_review'.tr,
                                style:
                                    textMd.copyWith(color: ColorResources.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(Icons.more_vert)),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        if (review?.user?.status == 'verified')
          Row(
            children: [
              SvgPicture.asset(Images.svgVerified),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Проверенный пользователь',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        Text(
          review?.review ?? '',
          // 'Заказывал у данной компании раскладные стулья для летника кофейни, отличное качество материалов и самих стульев. Выполнили  все в срок!',
          style: body14.copyWith(color: ColorResources.darkGray),
        ),
        const SizedBox(
          height: 10,
        ),
        if (review?.images != null && review!.images!.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: review?.images?.length ?? 0,
              itemBuilder: (context, index) {
                final image = review?.images?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomImage(
                      image: image?.thumb ?? '',
                      height: 72,
                      width: 72,
                      radius: 0),
                );
              },
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              formatDateInRu(review?.createdAt?.toString() ?? ''),
              // '12 сен. 2024',
              style: body12.copyWith(color: ColorResources.gray),
            ),
          ],
        ),
        if (review?.reply != null && review?.reply?.isNotEmpty == true)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: review?.reply?.length ?? 0,
            itemBuilder: (context, index) {
              final reply = review!.reply![index];
              // return Text(reply.answer ?? '');
              return _buildReplyWidget(reply);
            },
          ),
        if ("user" == "user") ...[
          const SizedBox(
            height: 10,
          ),
          if (review != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      ReviewReplyBottomWidget(
                        review: review!,
                        reviewIndex: reviewIndex!,
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                    );
                  },
                  child: Text(
                    'reply'.tr,
                    style: button16.copyWith(color: ColorResources.blue),
                  ),
                ),
              ],
            ),
        ],
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildReplyWidget(Reply reply) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatDateInRu(reply.createdAt?.toString() ?? ''),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: ColorResources.greyLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(reply.answer ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
