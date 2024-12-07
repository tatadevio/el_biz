import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/my_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewCompaniesWidget extends StatelessWidget {
  const NewCompaniesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Новые компании',
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return companiesItem();
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => MyCompaniesScreen());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Все компании ',
                    style: button16.copyWith(color: ColorResources.blue),
                  ),
                  SvgPicture.asset(Images.svgArrowForwardIcon),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget companiesItem() {
    double width = Get.width;
    return Container(
      width: width * 0.8,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: ColorResources.lgColor,
        ),
        color: ColorResources.lightBlue,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
            color: Color.fromRGBO(16, 24, 40, 0.1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.56,
                  color: ColorResources.lgColor,
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Садовая мебель Loft',
                      style: h16.copyWith(color: ColorResources.darkGray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                      ),
                    ),
                  ],
                ),
                Text(
                  'ОсОО...',
                  style: body14.copyWith(color: ColorResources.darkGray),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      Images.svgMap,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Кыргызстан, Бишкек',
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '(4,8)',
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 14,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Подробнее',
                          style: button16.copyWith(color: ColorResources.blue),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(Images.svgArrowForwardIcon),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
        ],
      ),
    );
  }
}
