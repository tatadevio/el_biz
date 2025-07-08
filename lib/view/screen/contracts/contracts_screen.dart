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
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isLoadingMore) {
        int pageSize = accountController.state.pageSize;
        if (accountController.state.currentPage < pageSize) {
          int nextPage = accountController.state.currentPage;
          if (isSale) {
            context.read<ContractsBloc>().add(GetCompanySales(
                companyId: contractId, currentPage: nextPage + 1));
          } else {
            context.read<ContractsBloc>().add(
                GetCompanyPurchases(companyId: contractId, currentPage: 1));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ContractsBloc, ContractsState>(
            builder: (context, contractState) {
          if (contractState.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (contractState.salesContractItems.isEmpty) {
            return Center(
              child: Text('no_contracts_found'.tr),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              if (isSale) {
                context.read<ContractsBloc>().add(
                    GetCompanySales(companyId: contractId, currentPage: 1));
              } else {
                context.read<ContractsBloc>().add(
                    GetCompanyPurchases(companyId: contractId, currentPage: 1));
              }
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: contractState.salesContractItems.length,
              // contractState.contracts.length,
              itemBuilder: (context, index) {
                return ContractItem(
                    contractModel: contractState.salesContractItems[index]);
              },
            ),
          );
        }),
      ),
    );
  }
}
