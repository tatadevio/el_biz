import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_detail_controller.dart';
import '../../../data/model/response/product/product_model.dart';
import '../../../data/repo/product_repo.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_image.dart';
import '../../base/custom_toast.dart';

class ProductCard extends StatelessWidget {
  final bool isFavorite;
  final String isEdit;
  final List<ProductItem> productItem;

  const ProductCard({Key? key, required this.isFavorite, required this.productItem, required this.isEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    bool _isLogin = context.watch<AuthBloc>().state.isLoggedIn;
    // Get.find<AuthController>().isLoggedIn();
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, productController) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 18.0),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: isEdit != "" ? 1 / 1.68 : 1 / 1.68, crossAxisSpacing: 12, mainAxisSpacing: 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: productItem.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Get.put(ProductRepo(Get.find(), Get.find()));
                // Get.put(ProductDetailController(Get.find()));

                // productController.getRelatedProduct(productItem[i].id.toString());
                // Get.find<ProductDetailController>().getProductDetail(productItem[i].id.toString());
                Get.toNamed(RouteHelper.getProductDetailRoute());
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      /*color: Theme.of(context).cardColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 0),
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                              ),
                            ]*/
                    ),
                    child: Column(
                      children: [
                        CustomImage(
                          radius: 10.0,
                          image: productItem[i].galleries.isNotEmpty ? productItem[i].galleries[0].image : "",
                          height: height * 0.2,
                          width: width * 0.48,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.svgLocation1,
                                    height: 20,
                                    width: 20,
                                    color: Color(0xff646F7F),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    productItem[i].city,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color.fromRGBO(100, 111, 127, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              Text(
                                productItem[i].name.isNotEmpty ? productItem[i].name : productItem[i].description,
                                style: const TextStyle(color: Colors.black87),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(
                                height: height * 0.008,
                              ),
                              if (productItem[i].priceAfterDiscount != "0")
                                productItem[i].currency == "KGS"
                                    ? Text(
                                        "${productItem[i].priceAfterDiscount} ${productItem[i].currency}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text(
                                        productItem[i].exchangePriceAfterDiscount,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                              // if (productItem[i].priceAfterDiscount != "0")
                              //   productItem[i].currency != "KGS"
                              //       ? Text(
                              //           "${productItem[i].priceAfterDiscount} ${productItem[i].currency}",
                              //           style: const TextStyle(
                              //             color: ColorResources.hintColor,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 16,
                              //           ),
                              //         )
                              //       : Text(
                              //           productItem[i]
                              //               .exchangePriceAfterDiscount,
                              //           style: const TextStyle(
                              //             color: ColorResources.hintColor,
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 16,
                              //           ),
                              //         ),

                              Row(
                                children: [
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (productItem[i].isVip)
                    Positioned(
                      left: 6,
                      top: 8,
                      child: Container(
                          height: 30,
                          width: width * 0.17,
                          decoration: BoxDecoration(
                            color: ColorResources.yellow,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                Images.svgStarFill,
                                width: 20,
                                color: Colors.white,
                              ),
                              const Text(
                                "VIP",
                                style: TextStyle(color: ColorResources.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  // if (isEdit == "")
                  // Positioned(
                  //   right: 1,
                  //   top: 4,
                  //   // height * 0.15,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       if (_isLogin) {
                  //         // Get.put(ProductRepo(Get.find(), Get.find()));
                  //         // if (productController.favIds.contains(productItem[i].id)) {
                  //         //   Get.find<ProductController>().removeFromFav(productItem[i].id.toString(), productItem[i]);
                  //         // } else {
                  //         //   Get.find<ProductController>().addToFav(productItem[i].id.toString(), productItem[i]);
                  //         // }
                  //       } else {
                  //         showShortToast("login_to_continue".tr);
                  //       }
                  //     },
                  //     child: Container(
                  //       height: 40,
                  //       width: 40,
                  //       decoration: BoxDecoration(
                  //           // color: Theme.of(context).cardColor,
                  //           // shape: BoxShape.rectangle,
                  //           borderRadius: BorderRadius.circular(10),
                  //           border: Border.all(
                  //             width: 1,
                  //             color: Theme.of(context).cardColor,
                  //           ),
                  //           boxShadow: const [
                  //             BoxShadow(
                  //               offset: Offset(0, 4), // Horizontal and vertical offset
                  //               blurRadius: 2, // Spread or blur amount
                  //               color: Color.fromRGBO(0, 0, 0, 0.15), // Color with alpha (opacity) value
                  //             )
                  //           ]),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(4.0),
                  //         child: productController.favIds.contains(productItem[i].id)
                  //             ? const Icon(Icons.favorite, color: ColorResources.orange)
                  //             : Icon(
                  //                 Icons.favorite_border,
                  //                 color: Theme.of(context).cardColor.withOpacity(1),
                  //               ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
