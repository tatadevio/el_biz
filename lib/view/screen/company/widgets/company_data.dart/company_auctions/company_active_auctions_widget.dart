import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/view/base/auction_grid_item.dart';
import 'package:el_biz/view/base/auction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../bloc/company_detail/company_detail_bloc.dart';

class CompanyActiveAuctionsWidget extends StatelessWidget {
  final ScrollController scrollController;
  const CompanyActiveAuctionsWidget(
      {super.key, required this.scrollController});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.activeAuctionShowMore) {
        int pageSize = accountController.state.activeAuctionPageSize;
        if (accountController.state.activeAuctionCurrentPage < pageSize) {
          int nextPage = accountController.state.activeAuctionCurrentPage;
          String companyId = context
                  .read<CompanyDetailBloc>()
                  .state
                  .companyDetailModel
                  ?.data
                  ?.id
                  .toString() ??
              '';
          print(
              'calling get company auctions api with current page = ${nextPage + 1} and isbottomloading = ${accountController.state.activeAuctionShowMore}');
          accountController
              .add(GetCompanyAuctions(companyId, currentPage: nextPage + 1));
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
        if (companyDetailState.companyAuctions == null ||
            companyDetailState.companyAuctions!.isEmpty) {
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
                itemCount: companyDetailState.companyAuctions?.length ?? 0,
                itemBuilder: (context, index) {
                  return AuctionGridItem(
                    auction: companyDetailState.companyAuctions![index],
                    isCompanyAuction: true,
                    isPublicAuction: false,
                  );
                },
              ),
            ] else ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companyDetailState.companyAuctions?.length ?? 0,
                itemBuilder: (context, index) {
                  return AuctionListItemWidget(
                    auction: companyDetailState.companyAuctions![index],
                    isCompanyAuction: true,
                    isPublicAuction: false,
                  );
                },
              ),
            ],
            if (companyDetailState.activeAuctionShowMore)
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
