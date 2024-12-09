import 'package:el_biz/controller/tenders_controller.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/tender_grid_item.dart';
import 'package:el_biz/view/base/tender_list_item.dart';
import 'package:el_biz/view/screen/filter/products_filter/products_filter_screen.dart';
import 'package:el_biz/view/screen/product/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TenderScreen extends StatelessWidget {
  const TenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'tender'.tr,
                  style: h16.copyWith(color: ColorResources.blackText),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: ColorResources.lgColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(Images.svgSearch),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const AddProductScreen());
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    color: ColorResources.green,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 1),
                        color: Color.fromRGBO(16, 24, 40, 0.05),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Images.svgPlus,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'new_tender'.tr,
                        style: button16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: GetBuilder<TendersController>(builder: (tendersController) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.to(() => ProductsFilterScreen());
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: ColorResources.green,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Color.fromRGBO(16, 24, 40, 0.05),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Images.filter,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'filter'.tr,
                              style: button16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border: Border.all(width: 1, color: ColorResources.lgColor),
                          color: ColorResources.lightBlue,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Color.fromRGBO(16, 24, 40, 0.05),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Images.svgArrowUpDown,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'new'.tr,
                              style: body14.copyWith(color: ColorResources.gray),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        tendersController.updateGridView(true);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: tendersController.isGridView ? ColorResources.primary : null,
                          border: Border.all(
                            width: 1,
                            color: tendersController.isGridView ? ColorResources.primary : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgCategory,
                          color: tendersController.isGridView ? ColorResources.white : ColorResources.gray,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        tendersController.updateGridView(false);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: tendersController.isGridView ? null : ColorResources.primary,
                          border: Border.all(
                            width: 1,
                            color: !tendersController.isGridView ? ColorResources.primary : ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgList,
                          color: !tendersController.isGridView ? ColorResources.white : ColorResources.gray,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
      body: GetBuilder<TendersController>(builder: (tendersController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: tendersController.isGridView
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.65),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TenderGridItem();
                  },
                )
              : ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TenderListItem();
                  },
                ),
        );
      }),
    );
  }
}
