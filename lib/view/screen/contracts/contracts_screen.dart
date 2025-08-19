import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/contracts/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ContractsScreen extends StatelessWidget {
  final bool isSale;
  final String contractId;
  const ContractsScreen(
      {super.key, required this.isSale, required this.contractId});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<ContractsBloc>();

    scrollController.addListener(() {
      if (isSale) {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 300 &&
            !accountController.state.isLoading &&
            !accountController.state.isSalesLoadingMore) {
          int pageSize = accountController.state.salesContractItemsPageSize;
          if (accountController.state.salesContractItemsCurrentPage <
              pageSize) {
            int nextPage =
                accountController.state.salesContractItemsCurrentPage;

            context.read<ContractsBloc>().add(GetCompanySales(
                companyId: contractId, currentPage: nextPage + 1));
          }
        }
      } else {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 300 &&
            !accountController.state.isLoading &&
            !accountController.state.isPurchasesLoadingMore) {
          int pageSize = accountController.state.purchasesContractItemsPageSize;
          if (accountController.state.purchasesContractItemsCurrentPage <
              pageSize) {
            int nextPage =
                accountController.state.purchasesContractItemsCurrentPage;

            context.read<ContractsBloc>().add(GetCompanyPurchases(
                companyId: contractId, currentPage: nextPage + 1));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    _callScrolling(context, _scrollController);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contracts'),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            if (isSale) {
              context
                  .read<ContractsBloc>()
                  .add(GetCompanySales(companyId: contractId, currentPage: 1));
            } else {
              context.read<ContractsBloc>().add(
                  GetCompanyPurchases(companyId: contractId, currentPage: 1));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<ContractsBloc, ContractsState>(
                builder: (context, contractState) {
              if (contractState.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (contractState.salesContractItems.isEmpty) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: Get.height * 0.78,
                    child: Center(child: Text('no_contracts_found'.tr)),
                  ),
                );
              }
              return SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: contractState.salesContractItems.length,
                      // contractState.contracts.length,
                      itemBuilder: (context, index) {
                        return ContractItem(
                            contractModel:
                                contractState.salesContractItems[index]);
                      },
                    ),
                    if (isSale && contractState.isSalesLoadingMore)
                      const Center(
                        child: CircularProgressIndicator(),
                      ).paddingOnly(
                          bottom: MediaQuery.of(context).padding.bottom),
                    if (!isSale && contractState.isPurchasesLoadingMore)
                      const Center(
                        child: CircularProgressIndicator(),
                      ).paddingOnly(
                          bottom: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
