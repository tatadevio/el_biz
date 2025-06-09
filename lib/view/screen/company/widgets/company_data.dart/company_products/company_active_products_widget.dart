import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../base/product_grid_item.dart';
import '../../../../../base/product_list_item.dart';

class CompanyActiveProductsWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyActiveProductsWidget(
      {super.key, required this.scrollController});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.productShowMore) {
        print('this is scroll view page ended....');
        int pageSize = accountController.state.productPageSize;
        if (accountController.state.productCurrentPage < pageSize) {
          int nextPage = accountController.state.productCurrentPage;
          String companyId = context
                  .read<CompanyDetailBloc>()
                  .state
                  .companyDetailModel
                  ?.data
                  ?.id
                  .toString() ??
              '';
          accountController
              .add(GetCompanyProducts(companyId, currentPage: nextPage + 1));
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
        if (companyDetailState.companyProducts == null ||
            companyDetailState.companyProducts!.isEmpty) {
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
                  return ProductListItemWidget(
                    product: productData,
                  );
                },
              ),
            ],
            if (companyDetailState.productShowMore)
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
