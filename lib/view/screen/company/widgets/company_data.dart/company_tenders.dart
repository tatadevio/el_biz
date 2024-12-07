import 'package:el_biz/controller/company_controller.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/custom_gridview_widget.dart';
import '../../../../base/custom_listview_widget.dart';
import '../../../../base/product_grid_item.dart';
import '../../../../base/product_list_item.dart';

class CompanyTenders extends StatelessWidget {
  const CompanyTenders({super.key});

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
                    companyController.updateShowTenders(true);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: companyController.isShowActiveTenders ? 2 : 1, color: companyController.isShowActiveTenders ? ColorResources.blue : ColorResources.lgColor),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Активно',
                      style: textSm.copyWith(color: companyController.isShowActiveTenders ? ColorResources.blue : ColorResources.lgColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    companyController.updateShowTenders(false);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: !companyController.isShowActiveTenders ? 2 : 1, color: !companyController.isShowActiveTenders ? ColorResources.blue : ColorResources.lgColor),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Неактивно',
                      style: textSm.copyWith(color: !companyController.isShowActiveTenders ? ColorResources.blue : ColorResources.lgColor),
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
                  isSelected: companyController.isShowTendersGridView,
                  onTap: () {
                    companyController.updateShowTendersGridView(true);
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomListviewWidget(
                  isSelected: !companyController.isShowTendersGridView,
                  onTap: () {
                    companyController.updateShowTendersGridView(false);
                  },
                ),
              ],
            ),
          ),
          if (companyController.isShowTendersGridView) ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.7),
              itemCount: 8,
              itemBuilder: (context, index) {
                return const ProductGridItem();
              },
            ),
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
