import 'dart:io';

import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../data/model/base/add_product_model.dart';
import '../../../base/custom_image.dart';
import 'review_photo_gallery.dart';

class AddProductImagesPreview extends StatefulWidget {
  final AddProductModel productData;
  const AddProductImagesPreview({super.key, required this.productData});

  @override
  State<AddProductImagesPreview> createState() =>
      _AddProductImagesPreviewState();
}

class _AddProductImagesPreviewState extends State<AddProductImagesPreview> {
  PageController _pageController = PageController();
  int _selectImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<ProductBloc, ProductState>(
        builder: (context, productController) {
      if (productController.pickedLogo.isEmpty) {
        return CustomImage(
            image: '', height: height * 0.4, width: Get.width, radius: 12);
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: InkWell(
              onTap: () {
                Get.to(() => ReviewPhotoGalleryView(
                      galleries: productController.pickedLogo,
                      productName: widget.productData.productName ?? '',
                      // selectedIndex: _selectImageIndex,
                    ));
              },
              child: SizedBox(
                height: height * 0.4,
                child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.pickedLogo.length,
                    // productDetailController.productDetailModel!.galleries.length,
                    onPageChanged: (value) {
                      setState(() {
                        _selectImageIndex = value;
                      });
                    },
                    itemBuilder: (context, i) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(productController.pickedLogo[i].path),
                              height: height * 0.4,
                              width: Get.width,
                              fit: BoxFit.cover,
                              // image: '',
                              // productDetailController.productDetailModel!.galleries[i].image,
                              // radius: 12.0,
                            ),
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
                                  "${i + 1}/${productController.pickedLogo.length}",
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
                itemCount: productController.pickedLogo.length,
                // productDetailController.productDetailModel!.galleries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      height: 80,
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: index != _selectImageIndex
                            ? Border.all(width: 1, color: Colors.white)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(productController.pickedLogo[index].path),
                            height: 78,
                            width: 78,
                            fit: BoxFit.cover,
                          )),

                      // CustomImage(
                      //   height: 78,
                      //   width: 78,
                      //   fit: BoxFit.cover,
                      //   image: '',
                      //   radius: 10.0,
                      // ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
