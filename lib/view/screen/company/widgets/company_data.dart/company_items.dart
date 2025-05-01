import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_gridview_widget.dart';
import 'package:el_biz/view/base/custom_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../base/product_grid_item.dart';
import '../../../../base/product_list_item.dart';

class CompanyItems extends StatelessWidget {
 
  const CompanyItems({super.key});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.productShowMore) {
        int pageSize = accountController.state.productPageSize;
        if (accountController.state.productCurrentPage < pageSize) {
          int nextPage = accountController.state.currentPage;
String companyId = context.read<CompanyDetailBloc>().state.companyDetailModel?.data?.id.toString() ?? '';
          accountController
              .add(GetCompanyProducts(companyId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    _callScrolling(context, _controller);
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyDetailState) {
      return BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, compnayState) {
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
            if (compnayState.isShowGoodsGridView) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                itemCount: companyDetailState.companyProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  final productData =
                      companyDetailState.companyProducts![index];
                  return ProductGridItem(
                    product: productData,
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companyDetailState.companyProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  final productData =
                      companyDetailState.companyProducts![index];
                  return ProductListItem(
                    product: productData,
                  );
                },
              ),
            ],
          ],
        );
      });
    });
  }
}
