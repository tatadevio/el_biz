import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_image.dart';
import '../../base/no_data.dart';
import 'categories.dart';
import 'sub_category.dart';

class MainCategories extends StatelessWidget {
  final bool type;
  final bool fromHome;
  const MainCategories({
    Key? key,
    required this.type,
    required this.fromHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: Text("category".tr),
      ),
      body: GetBuilder<CategoryController>(builder: (categoryController) {
        return categoryController.categoryItem.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(12.0),
                      //     child: Container(
                      //       height: 48,
                      //       decoration: BoxDecoration(
                      //         color: const Color.fromRGBO(245, 245, 245, 1),
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //       child: TextFormField(
                      //         textAlign: TextAlign.center,
                      //         onTap: () {
                      //           // Navigate to the desired screen
                      //           // Get.to(() => SearchScreen());
                      //         },
                      //         decoration: InputDecoration(
                      //           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      //           isDense: true, // Ensures compact styling
                      //           isCollapsed: true,
                      //           border: InputBorder.none,
                      //           focusedBorder: InputBorder.none,
                      //           enabledBorder: InputBorder.none,
                      //           errorBorder: InputBorder.none,
                      //           disabledBorder: InputBorder.none,
                      //           hintText: "search_categories".tr,
                      //           filled: false,
                      //           // fillColor: const Color.fromRGBO(245, 245, 245, 1), // Background color
                      //           hintStyle: const TextStyle(
                      //             color: Color.fromRGBO(100, 111, 127, 1),
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w400,
                      //             fontFamily: 'Inter',
                      //           ),

                      //           prefixIcon: Padding(
                      //             padding: const EdgeInsets.all(12.0),
                      //             child: SvgPicture.asset(
                      //               Images.svgSearch,
                      //               color: const Color.fromRGBO(100, 111, 127, 1),
                      //               height: 24,
                      //             ),
                      //           ),
                      //           suffixIcon: const SizedBox.shrink(),
                      //           // prefixIconConstraints: const BoxConstraints(
                      //           //   minWidth: 40,
                      //           //   minHeight: 40,
                      //           // ),
                      //         ),
                      //         textAlignVertical: TextAlignVertical.center,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: categoryController.categoryItem.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  if (categoryController.categoryItem[i].childs.isNotEmpty) {
                                    // Get.to(() => SubCategories(title: categoryController.categoryItem[i].name,
                                    //   categoryItem: categoryController.categoryItem[i].childs,type: type,));

                                    Get.to(() => CategoryScreens(
                                          category: categoryController.categoryItem[i],
                                          fromHome: fromHome,
                                        ));
                                  } else {
                                    Get.find<ProductController>().getProductWithCat(categoryController.categoryItem[i].id.toString(), categoryController.categoryItem[i].name);
                                    Get.to(() => Categories(
                                          title: categoryController.categoryItem[i].name,
                                          categoryItem: categoryController.categoryItem[i].childs,
                                          id: categoryController.categoryItem[i].id.toString(),
                                        ));
                                  }
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      leading: CustomImage(
                                        image: categoryController.categoryItem[i].image,
                                        height: 24,
                                        width: 24,
                                        radius: 0.0,
                                      ),
                                      title: Text(
                                        categoryController.categoryItem[i].name,
                                        style: body16.copyWith(color: ColorResources.darkGray),

                                        //  const TextStyle(color: ColorResources.textBlack, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                                      ),
                                      trailing: SvgPicture.asset(Images.svgArrowRight),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      color: ColorResources.background,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : NoDataWidget(
                image: Images.logout,
                title: "authorize".tr,
                description: "logout_desc".tr,
                btnTxt: "login_by_gmail".tr,
                onTap: () {
                  Get.offAllNamed(RouteHelper.getLoginRoute());
                },
              );
      }),
    );
  }
}
