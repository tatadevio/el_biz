import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/view/base/auction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../base/auction_grid_item.dart';

class CompanyInActiveAuctionsWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyInActiveAuctionsWidget(
      {super.key, required this.scrollController});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.inActiveAuctionShowMore) {
        int pageSize = accountController.state.inActiveAuctionPageSize;
        if (accountController.state.inActiveAuctionCurrentPage < pageSize) {
          int nextPage = accountController.state.inActiveAuctionCurrentPage;
          String companyId = context
                  .read<CompanyDetailBloc>()
                  .state
                  .companyDetailModel
                  ?.data
                  ?.id
                  .toString() ??
              '';
          accountController.add(
              GetCompanyInActiveAuctions(companyId, currentPage: nextPage + 1));
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
        if (companyDetailState.companyInactiveAuctions == null ||
            companyDetailState.companyInactiveAuctions!.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('no_auction_found'.tr),
            ),
          );
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            if (companyState.isShowAuctionsGridView) ...[
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.65),
                itemCount:
                    companyDetailState.companyInactiveAuctions?.length ?? 0,
                itemBuilder: (context, index) {
                  return AuctionGridItem(
                    auction: companyDetailState.companyInactiveAuctions![index],
                    isCompanyAuction: true,
                    isPublicAuction: false,
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    companyDetailState.companyInactiveAuctions?.length ?? 0,
                itemBuilder: (context, index) {
                  return AuctionListItemWidget(
                    auction: companyDetailState.companyInactiveAuctions![index],
                    isCompanyAuction: true,
                    isPublicAuction: false,
                  );
                },
              ),
            ],
            if (companyDetailState.inActiveAuctionShowMore)
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
