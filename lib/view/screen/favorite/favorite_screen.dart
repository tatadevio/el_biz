import 'package:el_biz/controller/favorite_controller.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/product_grid_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'favorites'.tr,
          style: h16.copyWith(color: ColorResources.blackText),
        ),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: GetBuilder<FavoriteController>(builder: (favoriteController) {
            return Container(
              // decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0))),
              color: ColorResources.background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: SizedBox(
                      height: height * 0.06,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  favoriteController.updateShowCategories(true);
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(6),
                                    border: Border(
                                      bottom: BorderSide(
                                        width: favoriteController.isShowCategories ? 2 : 1,
                                        color: favoriteController.isShowCategories ? ColorResources.blue : ColorResources.lgColor,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Закупки".tr,
                                    style: mediumTextStyle.copyWith(
                                      color: favoriteController.isShowCategories ? ColorResources.primary : ColorResources.black,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  favoriteController.updateShowCategories(false);
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: !favoriteController.isShowCategories ? 2 : 1,
                                        color: !favoriteController.isShowCategories ? ColorResources.blue : ColorResources.lgColor,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text("goods".tr,
                                          style: mediumTextStyle.copyWith(
                                            color: !favoriteController.isShowCategories ? ColorResources.primary : ColorResources.black,
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ProductGridItem(
              isFavorite: true,
            );
          },
        ),
      ),
    );
  }
}
