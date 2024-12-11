import 'package:el_biz/bloc/review/review_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои отзывы'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ReviewBloc, ReviewState>(builder: (context, reviewController) {
          if (reviewController.myReviews!.isEmpty) {
            return Center(
              child: Text(
                'Вы еще не оставляли отзывов',
                style: body14.copyWith(color: ColorResources.gray),
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return myReviewItem();
            },
          );
        }),
      ),
    );
  }

  Widget myReviewItem() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorResources.lightBlue,
              border: Border.all(width: 1, color: ColorResources.lgColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              leading: CustomImage(
                height: 40,
                width: 40,
                image: '',
                radius: 7.74,
              ),
              title: Text(
                'Садовая мебель Loft',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      '2 500 сом/шт',
                      style: h16.copyWith(color: ColorResources.blue),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ReviewItem(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Удалить отзыв',
                style: button16.copyWith(color: ColorResources.red),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
