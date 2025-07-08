import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/contracts/contract_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyPurchasesWidget extends StatelessWidget {
  final String currentUserId;

  const MyPurchasesWidget({super.key, required this.currentUserId});

  reloadAllMessages(BuildContext context) async {
    final agreementState = context.read<AgreementBloc>().state;
    if (agreementState.purchasesSearchQuery.isNotEmpty) {
      context.read<AgreementBloc>().add(SearchMyPurchases(
          query: agreementState.purchasesSearchQuery, currentPage: 1));
    } else {
      context.read<AgreementBloc>().add(GetMyPurchases(currentPage: 1));
    }
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final agreementBloc = context.read<AgreementBloc>();

    scrollController.addListener(() {
      final agreementState = agreementBloc.state;

      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !agreementState.isLoading &&
          !agreementState.isLoadingMore &&
          !agreementState.isSearchingPurchases &&
          !agreementState.isLoadingPurchasesSearchMore) {
        if (agreementState.purchasesSearchQuery.isNotEmpty) {
          // Search pagination
          if (agreementState.purchasesSearchCurrentPage <
              agreementState.purchasesSearchPageSize) {
            agreementBloc.add(SearchMyPurchases(
              query: agreementState.purchasesSearchQuery,
              currentPage: agreementState.purchasesSearchCurrentPage + 1,
            ));
          }
        } else {
          // Normal pagination
          if (agreementState.myPurchasesCurrentPage <
              agreementState.myPurchasesPageSize) {
            agreementBloc.add(GetMyPurchases(
                currentPage: agreementState.myPurchasesCurrentPage + 1));
          }
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
          if (agreement.isLoading || agreement.isSearchingPurchases) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use filtered results if search is active, otherwise use original list
          final displayList = agreement.purchasesSearchQuery.isNotEmpty
              ? agreement.filteredMyPurchases
              : agreement.myPurchases;

          if (displayList.isEmpty) {
            if (agreement.purchasesSearchQuery.isNotEmpty) {
              return Center(child: Text('no_search_results'.tr));
            } else {
              return Center(child: Text('no_contract_found'.tr));
            }
          }

          return ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: displayList.length +
                (agreement.isLoadingPurchasesSearchMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == displayList.length &&
                  agreement.isLoadingPurchasesSearchMore) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final chat = displayList[index];
              return ContractTileWidget(
                contractData: chat,
                isSales: false,
              );
            },
          );
        },
      ),
    );
  }
}
