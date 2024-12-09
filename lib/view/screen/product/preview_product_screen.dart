import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import './widgets/add_product_images_preview.dart';

class PreviewProductScreen extends StatefulWidget {
  const PreviewProductScreen({super.key});

  @override
  State<PreviewProductScreen> createState() => _PreviewProductScreenState();
}

class _PreviewProductScreenState extends State<PreviewProductScreen> {
  bool _isShowDescription = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AddProductImagesPreview(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Стул раскладной',
                          style: h24.copyWith(color: ColorResources.darkGray),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: ColorResources.lgColor),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Color.fromRGBO(16, 24, 40, 0.05),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Images.svgHeartBorder),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Раскладной садовый стул из шпона дерева.',
                    style: body16.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '2 500 сом',
                    style: h24.copyWith(color: ColorResources.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '(0) ',
                              style: body14.copyWith(color: ColorResources.gray),
                            ),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 14,
                              ignoreGestures: true,
                              itemPadding: EdgeInsets.symmetric(horizontal: 0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: ColorResources.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Загружено: ',
                            style: body14.copyWith(color: ColorResources.gray, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '12 окт. 2024',
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          'Минимальный заказ: ',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        Text(
                          '5 шт',
                          style: body16.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text(
                          'Наличие: ',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        Text(
                          'Уточнять наличие',
                          style: body16.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          setState(() {
                            _isShowDescription = true;
                          });
                          // productDetialController.toggleShowProductReview(false);
                        },
                        child: Container(
                          height: 40,
                          width: width * 0.43,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: !_isShowDescription ? null : ColorResources.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'О товаре',
                            style: button16.copyWith(color: !_isShowDescription ? ColorResources.gray : ColorResources.white),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          setState(() {
                            _isShowDescription = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: width * 0.45,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: _isShowDescription ? null : ColorResources.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Отзывы',
                            style: button16.copyWith(color: _isShowDescription ? ColorResources.gray : ColorResources.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  // if (!_isShowDescription) ...[
                  //   ProductReviewsWidget(),
                  // ] else ...[
                  //   AboutProductWidget(),
                  // ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
