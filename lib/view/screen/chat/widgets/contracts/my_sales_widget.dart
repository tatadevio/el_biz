import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/contracts/contract_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MySalesWidget extends StatelessWidget {
  final String currentUserId;

  const MySalesWidget({super.key, required this.currentUserId});

  reloadAllMessages(BuildContext context) async {
    context.read<AgreementBloc>().add(GetMySales(currentPage: 1));
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<AgreementBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isLoadingMore) {
        print('this is scroll view page ended....');
        int pageSize = accountController.state.mySalesPageSize;
        if (accountController.state.mySalesCurrentPage < pageSize) {
          int nextPage = accountController.state.mySalesCurrentPage;

          accountController.add(GetMySales(currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    _callScrolling(context, scrollController);
    return RefreshIndicator(
      onRefresh: () async => reloadAllMessages(context),
      child: BlocBuilder<AgreementBloc, AgreementState>(
        builder: (context, agreement) {
          if (agreement.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (agreement.mySales.isEmpty) {
            return Center(child: Text('no_contract_found'.tr));
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: agreement.mySales.length,
            itemBuilder: (context, index) {
              final chat = agreement.mySales[index];
              return ContractTileWidget(
                contractData: chat,
                isSales: true,
              );
            },
          );
        },
      ),
    );
  }
}
