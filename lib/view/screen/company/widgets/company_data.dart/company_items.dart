import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_gridview_widget.dart';
import 'package:el_biz/view/base/custom_listview_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_products/company_active_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import 'company_products/company_inactive_products_widget.dart';

class CompanyItems extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyItems({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyDetailState) {
      return BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, compnayState) {
        // if (companyDetailState.companyProducts!.isEmpty) {
        //   return Center(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(vertical: 10),
        //       child: Text('no_product_found'.tr),
        //     ),
        //   );
        // }
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
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowGood(true));
                      // compnayState.updateShowGood(true);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: compnayState.isShowActiveGoods ? 2 : 1,
                              color: compnayState.isShowActiveGoods
                                  ? ColorResources.blue
                                  : ColorResources.lgColor),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'actively'.tr,
                        style: textSm.copyWith(
                            color: compnayState.isShowActiveGoods
                                ? ColorResources.blue
                                : ColorResources.lgColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowGood(false));
                      // compnayState.updateShowGood(false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: !compnayState.isShowActiveGoods ? 2 : 1,
                              color: !compnayState.isShowActiveGoods
                                  ? ColorResources.blue
                                  : ColorResources.lgColor),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'inactive'.tr,
                        style: textSm.copyWith(
                            color: !compnayState.isShowActiveGoods
                                ? ColorResources.blue
                                : ColorResources.lgColor),
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
                    isSelected: compnayState.isShowGoodsGridView,
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowGoodsGridView(true));
                      // compnayState.updateShowGoodsGridView(true);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomListviewWidget(
                    isSelected: !compnayState.isShowGoodsGridView,
                    onTap: () {
                      context
                          .read<CompanyBloc>()
                          .add(const UpdateShowGoodsGridView(false));

                      // compnayState.updateShowGoodsGridView(false);
                    },
                  ),
                ],
              ),
            ),
            if (compnayState.isShowActiveGoods)
              CompanyActiveProductsWidget(
                scrollController: scrollController,
              ),
            if (!compnayState.isShowActiveGoods)
              CompanyInActiveProductsWidget(
                scrollController: scrollController,
              ),
          ],
        );
      });
    });
  }
}
