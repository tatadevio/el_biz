import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../base/tender_grid_item.dart';
import '../../../../../base/tender_list_item.dart';

class CompanyInActiveTendersWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyInActiveTendersWidget(
      {super.key, required this.scrollController});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.inActiveTenderShowMore) {
        int pageSize = accountController.state.inActiveTenderPageSize;
        if (accountController.state.inActiveTenderCurrentPage < pageSize) {
          int nextPage = accountController.state.inActiveTenderCurrentPage;
          String companyId = context
                  .read<CompanyDetailBloc>()
                  .state
                  .companyDetailModel
                  ?.data
                  ?.id
                  .toString() ??
              '';
          accountController
              .add(GetCompanyTenders(companyId, currentPage: nextPage + 1));
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
        if (companyDetailState.companyInactiveTenders == null ||
            companyDetailState.companyInactiveTenders!.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('no_tender_found'.tr),
            ),
          );
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            if (companyState.isShowTendersGridView) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount:
                    companyDetailState.companyInactiveTenders?.length ?? 0,
                itemBuilder: (context, index) {
                  return TenderGridItem(
                    tender: companyDetailState.companyInactiveTenders![index],
                    isCompanyTender: true,
                    isPublicTender: false,
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    companyDetailState.companyInactiveTenders?.length ?? 0,
                itemBuilder: (context, index) {
                  return TenderListItem(
                    tender: companyDetailState.companyInactiveTenders![index],
                    isCompanyTender: true,
                    isPublicTender: false,
                  );
                },
              ),
            ],
            if (companyDetailState.inActiveTenderShowMore)
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
