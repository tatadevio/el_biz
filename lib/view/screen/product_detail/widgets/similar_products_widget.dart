import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/similar_products/similar_products_bloc.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../base/custom_like_button.dart';
import '../product_detail_screen.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({super.key});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final similarProductsBloc = context.read<SimilarProductsBloc>();
    String productId = context
        .read<ProductDetailBloc>()
        .state
        .productDetailModel!
        .data!
        .id
        .toString();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !similarProductsBloc.state.isLoading &&
          !similarProductsBloc.state.isMoreLoading) {
        int pageSize = similarProductsBloc.state.pageSize;
        if (similarProductsBloc.state.currentPage < pageSize) {
          int nextPage = similarProductsBloc.state.currentPage;

          similarProductsBloc.add(GetSimilarProducts(
              productId: productId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    _callScrolling(context, _controller);
    return BlocBuilder<SimilarProductsBloc, SimilarProductsState>(
        builder: (context, similarProductState) {
      if (similarProductState.isLoading ||
          similarProductState.similarProduct.isEmpty) {
        return SizedBox();
      }
      return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Похожие товары',
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: Get.height * 0.45,
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: similarProductState.similarProduct.length,
                itemBuilder: (context, index) {
                  // return SizedBox(width: Get.width / 2.2, child: ProductGridItem());
                  return productItem(similarProductState.similarProduct[index]);
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Widget productItem(ProductListItem product) {
    double height = Get.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailScreen());
        },
        child: SizedBox(
          width: Get.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImage(
                      image: '',
                      height: Get.height * 0.25,
                      width: Get.width * 0.4,
                      radius: 16),
                  Positioned(top: 7, right: 7, child: CustomLikeButton()),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                product.name ?? '',
                // 'Стул раскладной',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                product.description ?? '',
                // 'Раскладной садовый стул из дерева',
                style: body14.copyWith(color: ColorResources.gray),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '${product.price} сом/шт',
                style: h16.copyWith(color: ColorResources.blue),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    '(${product.reviewsAvgRating}) ',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  RatingBar.builder(
                    initialRating:
                        double.tryParse(product.reviewsAvgRating ?? '0') ?? 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
