import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_reply_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/Images.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/custom_text_style.dart';
import '../../../../base/custom_image.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Садовая мебель Loft',
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
                  initialRating: 5,
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
          'Заказывал у данной компании раскладные стулья для летника кофейни, отличное качество материалов и самих стульев. Выполнили  все в срок!',
          style: body14.copyWith(color: ColorResources.darkGray),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomImage(image: '', height: 72, width: 72, radius: 0),
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
              '12 сен. 2024',
              style: body12.copyWith(color: ColorResources.gray),
            ),
          ],
        ),
        if ("user" == "user") ...[
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    const ReviewReplyBottomWidget(),
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
}
