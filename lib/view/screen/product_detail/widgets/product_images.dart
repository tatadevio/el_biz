import 'package:el_biz/data/model/response/tender/tender_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/response/product/product_detail_model.dart';
import '../../../base/custom_image.dart';

class ProductImages extends StatefulWidget {
  final List<Media> image;
  final bool isProductDetail;
  final List<ProductDetailImages>? productDetailImages;
  const ProductImages(
      {super.key,
      required this.image,
      this.isProductDetail = false,
      this.productDetailImages});

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  PageController _pageController = PageController();
  int _selectImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: InkWell(
            onTap: () {
              // Get.to(() => PhotoGalleryView(
              //       galleries: productDetailController.productDetailModel!.galleries,
              //       productName: productDetailController.productDetailModel!.description,
              //       selectedIndex: _selectImageIndex,
              //     ));
            },
            child: SizedBox(
              height: height * 0.4,
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.isProductDetail
                      ? widget.productDetailImages!.length
                      : widget.image.length,
                  onPageChanged: (value) {
                    setState(() {
                      _selectImageIndex = value;
                    });
                  },
                  itemBuilder: (context, i) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImage(
                          height: height * 0.4,
                          width: Get.width,
                          fit: BoxFit.cover,
                          image: widget.isProductDetail
                              ? widget.productDetailImages![i].large ?? ''
                              : widget.image[i].url ?? '',
                          radius: 12.0,
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 5, bottom: 5, right: 12),
                              child: Text(
                                "${i + 1}/${widget.isProductDetail ? widget.productDetailImages!.length : widget.image.length}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SizedBox(
            height: 82,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.isProductDetail
                  ? widget.productDetailImages!.length
                  : widget.image.length,
              // productDetailController.productDetailModel!.galleries.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    _pageController.jumpToPage(index);
                  },
                  child: Container(
                    height: 80,
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: index == _selectImageIndex
                          ? Border.all(width: 2, color: Colors.white)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomImage(
                      height: 78,
                      width: 78,
                      fit: BoxFit.cover,
                      image: widget.isProductDetail
                          ? widget.productDetailImages![index].small ?? ''
                          : widget.image[index].url ?? '',
                      radius: 10.0,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
