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
              Get.to(() => SearchScreen());
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
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  'Проверенные компании',
                                  style: h24.copyWith(color: ColorResources.darkGray),
                                ),
                                Text(
                                  'Ваша площадка  для партнерства  и сотрудничества',
                                  style: body16.copyWith(color: ColorResources.gray),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
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
                  title: 'Компании',
                  titleImage: Images.svgBriefcase,
                  detail: 'База оптовых поставщиков, производителей товаров или услуги по логистике',
                  backgroundColor: ColorResources.blue,
                  onTap: () {
                    Get.to(() => MyCompaniesScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                  title: 'Товары',
                  titleImage: Images.svgShoppingBag,
                  detail: 'Найти товары от производителей и поставщиков',
                  backgroundColor: ColorResources.green,
                  onTap: () {
                    Get.find<ProductController>().updateShowCategories(false);
                    Get.to(() => ProductScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                title: 'Тендеры',
                titleImage: Images.svgTenders,
                detail: 'Посмотреть объявления о закупках товаров или добавить свое',
                backgroundColor: ColorResources.orange,
                onTap: () {
                  Get.find<ProductController>().updateShowCategories(true);
                  Get.to(() => ProductScreen());
                },
              ),
              SizedBox(
                height: height * 0.025,
              ),
              homeOptions(
                  title: 'Избранное',
                  titleImage: Images.svgHeart,
                  detail: 'Сохранённые товары, компании и тендеры.',
                  backgroundColor: ColorResources.red,
                  onTap: () {
                    Get.to(() => FavoriteScreen());
                  }),
              SizedBox(
                height: height * 0.025,
              ),
              NewCompaniesWidget(),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(22, 77, 160, 1),
                  gradient: LinearGradient(
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
                      'Добавьте свою компанию',
                      style: h24.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Чтобы найти поставщиков или покупателей, необходимо добавить компанию',
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
                      title: 'Добавить',
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
