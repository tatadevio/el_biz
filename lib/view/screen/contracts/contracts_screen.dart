import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/contracts/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  // void _callScrolling(BuildContext context, ScrollController scrollController) {
  //   final accountController = context.read<ContractsBloc>();

  //   // scrollController.addListener(() {
  //   //   if (scrollController.position.pixels >=
  //   //           scrollController.position.maxScrollExtent - 300 &&
  //   //       !accountController.state.isLoading &&
  //   //       !accountController.state.inActiveTenderShowMore) {
  //   //     int pageSize = accountController.state.inActiveTenderPageSize;
  //   //     if (accountController.state.inActiveTenderCurrentPage < pageSize) {
  //   //       int nextPage = accountController.state.inActiveTenderCurrentPage;
  //   //       String companyId = context
  //   //               .read<CompanyDetailBloc>()
  //   //               .state
  //   //               .companyDetailModel
  //   //               ?.data
  //   //               ?.id
  //   //               .toString() ??
  //   //           '';
  //   //       accountController
  //   //           .add(GetCompanyTenders(companyId, currentPage: nextPage + 1));
  //   //     }
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    // _callScrolling(context, _scrollController);
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
          return ListView.builder(
            controller: _scrollController,
            itemCount: contractState.salesContractItems.length,
            // contractState.contracts.length,
            itemBuilder: (context, index) {
              return ContractItem(
                  contractModel: contractState.salesContractItems[index]);
            },
          );
        }),
      ),
    );
  }
}
