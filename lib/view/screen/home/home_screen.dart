import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/screen/company/my_companies_screen.dart';
import 'package:el_biz/view/screen/favorite/favorite_screen.dart';
import 'package:el_biz/view/screen/home/widgets/new_companies_widget.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../company/widgets/fill_company_data_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset(
        //   Images.splashLogo,
        //   height: 40,
        // ),
        title: Image.asset(
          Images.splashLogo,
          height: 40,
          width: 40,
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Get.to(() => const SearchScreen());
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(border: Border.all(width: 1, color: ColorResources.lgColor), borderRadius: BorderRadius.circular(12), color: Colors.white),
              alignment: Alignment.center,
              child: SvgPicture.asset(Images.svgSearch),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const AppbarNotificationButton(),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                // .symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: SizedBox(
                            // padding: const EdgeInsets.only(top: 24, bottom: 24, left: 20),

                            // .symmetric(horizontal: 20, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  'verified_companies'.tr,
                                  style: h24.copyWith(color: ColorResources.darkGray),
                                ),
                                Text(
                                  'your_platform_for_partnership_and_cooperation'.tr,
                                  style: body16.copyWith(color: ColorResources.gray),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 8,
                          child: SizedBox(),
                          // Image.asset(
                          //   Images.companiesIcon,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        Images.companiesIcon,
                        fit: BoxFit.cover,
                        width: width * 0.45,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              homeOptions(
                  title: 'companies'.tr,
                  titleImage: Images.svgBriefcase,
                  detail: 'base_of_wholesale_suppliers_manufacturers_of_goods_or_logistics_services'.tr,
                  backgroundColor: ColorResources.blue,
                  onTap: () {
                    Get.to(() => const MyCompaniesScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                  title: 'goods'.tr,
                  titleImage: Images.svgShoppingBag,
                  detail: 'find_products_from_manufacturers_and_suppliers'.tr,
                  backgroundColor: ColorResources.green,
                  onTap: () {
                    Get.find<ProductController>().updateShowCategories(false);
                    Get.to(() => const ProductScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                title: 'tenders'.tr,
                titleImage: Images.svgTenders,
                detail: 'view_advertisements_for_purchasing_goods_or_add_your_own'.tr,
                backgroundColor: ColorResources.orange,
                onTap: () {
                  Get.find<ProductController>().updateShowCategories(true);
                  Get.to(() => const ProductScreen());
                },
              ),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                  title: 'favorites'.tr,
                  titleImage: Images.svgHeart,
                  detail: 'saved_goods_companies_and_tenders'.tr,
                  backgroundColor: ColorResources.red,
                  onTap: () {
                    Get.to(() => const FavoriteScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              const NewCompaniesWidget(),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(22, 77, 160, 1),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(22, 77, 160, 1),
                      Color.fromRGBO(22, 77, 160, 1),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'add_your_company'.tr,
                      style: h24.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'to_find_suppliers_or_buyers_you_need_to_add_a_company'.tr,
                      style: body16.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      width: width,
                      height: 44,
                      onTap: () {
                        Get.dialog(
                          const CustomDialog(
                            widget: AlertDialog(
                              backgroundColor: Colors.white,
                              titlePadding: EdgeInsets.all(0),
                              contentPadding: EdgeInsets.all(5),
                              content: Padding(
                                padding: EdgeInsets.all(0),
                                child: FillCompanyDataBox(),
                              ),
                            ),
                          ),
                        );
                      },
                      title: 'add',
                      color: ColorResources.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeOptions({String? title, String? detail, String? titleImage, Color? backgroundColor, Function()? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 1),
              color: Color.fromRGBO(16, 24, 40, 0.05),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  titleImage!,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title ?? '',
                  style: h16,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              detail ?? '',
              style: body14.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
