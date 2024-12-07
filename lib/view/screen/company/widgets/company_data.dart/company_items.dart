import 'package:el_biz/controller/company_controller.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_gridview_widget.dart';
import 'package:el_biz/view/base/custom_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/product_grid_item.dart';
import '../../../../base/product_list_item.dart';

class CompanyItems extends StatelessWidget {
  const CompanyItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(builder: (companyController) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    companyController.updateShowGood(true);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: companyController.isShowActiveGoods ? 2 : 1, color: companyController.isShowActiveGoods ? ColorResources.blue : ColorResources.lgColor),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Активно',
                      style: textSm.copyWith(color: companyController.isShowActiveGoods ? ColorResources.blue : ColorResources.lgColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    companyController.updateShowGood(false);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: !companyController.isShowActiveGoods ? 2 : 1, color: !companyController.isShowActiveGoods ? ColorResources.blue : ColorResources.lgColor),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Неактивно',
                      style: textSm.copyWith(color: !companyController.isShowActiveGoods ? ColorResources.blue : ColorResources.lgColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomGridviewWidget(
                  isSelected: companyController.isShowGoodsGridView,
                  onTap: () {
                    companyController.updateShowGoodsGridView(true);
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomListviewWidget(
                  isSelected: !companyController.isShowGoodsGridView,
                  onTap: () {
                    companyController.updateShowGoodsGridView(false);
                  },
                ),
              ],
            ),
          ),
          if (companyController.isShowGoodsGridView) ...[
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const ProductGridItem();
              },
            ),
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const ProductListItem();
              },
            ),
          ],
        ],
      );
    });
  }
}
