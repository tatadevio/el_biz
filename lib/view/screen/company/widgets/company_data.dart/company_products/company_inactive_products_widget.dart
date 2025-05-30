import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../base/product_grid_item.dart';
import '../../../../../base/product_list_item.dart';

class CompanyInActiveProductsWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyInActiveProductsWidget(
      {super.key, required this.scrollController});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.inActiveProductShowMore) {
        print('this is scroll view page ended....');
        int pageSize = accountController.state.inActiveProductPageSize;
        if (accountController.state.inActiveProductCurrentPage < pageSize) {
          int nextPage = accountController.state.inActiveProductPageSize;
          String companyId = context
                  .read<CompanyDetailBloc>()
                  .state
                  .companyDetailModel
                  ?.data
                  ?.id
                  .toString() ??
              '';
          accountController.add(
              GetCompanyInactiveProducts(companyId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _callScrolling(context, scrollController);
    return BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, companyState) {
      return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, companyDetailState) {
        if (companyDetailState.companyInactiveProducts == null ||
            companyDetailState.companyInactiveProducts!.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('no_product_found'.tr),
            ),
          );
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            if (companyState.isShowGoodsGridView) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                itemCount:
                    companyDetailState.companyInactiveProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  final productData =
                      companyDetailState.companyInactiveProducts![index];
                  return ProductGridItem(
                    product: productData,
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    companyDetailState.companyInactiveProducts?.length ?? 0,
                itemBuilder: (context, index) {
                  final productData =
                      companyDetailState.companyInactiveProducts![index];
                  return ProductListItemWidget(
                    product: productData,
                  );
                },
              ),
            ],
            if (companyDetailState.inActiveProductShowMore)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      });
    });
  }
}
