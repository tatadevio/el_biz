import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_textfield.dart';

class ContractTopBar extends StatefulWidget {
  const ContractTopBar({super.key});

  @override
  State<ContractTopBar> createState() => _ContractTopBarState();
}

class _ContractTopBarState extends State<ContractTopBar> {
  final TextEditingController purchasesSearchController =
      TextEditingController();
  final TextEditingController salesSearchController = TextEditingController();
  Timer? _purchasesSearchTimer;
  Timer? _salesSearchTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the appropriate search text based on current tab state
    final chatState = context.read<ChatBloc>().state;
    final agreementState = context.read<AgreementBloc>().state;

    if (chatState.isShowMySales) {
      // Show sales search text
      if (salesSearchController.text != agreementState.salesSearchQuery) {
        salesSearchController.text = agreementState.salesSearchQuery;
      }
    } else {
      // Show purchases search text
      if (purchasesSearchController.text !=
          agreementState.purchasesSearchQuery) {
        purchasesSearchController.text = agreementState.purchasesSearchQuery;
      }
    }
  }

  @override
  void dispose() {
    _purchasesSearchTimer?.cancel();
    _salesSearchTimer?.cancel();
    purchasesSearchController.dispose();
    salesSearchController.dispose();
    super.dispose();
  }

  void _onPurchasesSearchChanged(String query) {
    _purchasesSearchTimer?.cancel();
    _purchasesSearchTimer = Timer(const Duration(milliseconds: 300), () {
      context
          .read<AgreementBloc>()
          .add(SearchMyPurchases(query: query, currentPage: 1));
    });
  }

  void _onSalesSearchChanged(String query) {
    _salesSearchTimer?.cancel();
    _salesSearchTimer = Timer(const Duration(milliseconds: 300), () {
      context
          .read<AgreementBloc>()
          .add(SearchMySales(query: query, currentPage: 1));
    });
  }

  void _clearPurchasesSearch() {
    purchasesSearchController.clear();
    context
        .read<AgreementBloc>()
        .add(SearchMyPurchases(query: '', currentPage: 1));
  }

  void _clearSalesSearch() {
    salesSearchController.clear();
    context.read<AgreementBloc>().add(SearchMySales(query: '', currentPage: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      return Column(
        children: [
          if (!chatState.isShowMySales)
            CustomTextField(
              controller: purchasesSearchController,
              hintColor: 'search_in_contracts'.tr,
              inputType: TextInputType.text,
              leading: Images.svgSearch,
              readOnly: false,
              onChanged: _onPurchasesSearchChanged,
              suffix: IconButton(
                onPressed: _clearPurchasesSearch,
                icon: const Icon(Icons.close),
              ),
            ),
          if (chatState.isShowMySales)
            CustomTextField(
              controller: salesSearchController,
              hintColor: 'search_in_contracts'.tr,
              inputType: TextInputType.text,
              leading: Images.svgSearch,
              readOnly: false,
              onChanged: _onSalesSearchChanged,
              suffix: IconButton(
                onPressed: _clearSalesSearch,
                icon: const Icon(Icons.close),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context
                        .read<ChatBloc>()
                        .add(const UpdateShowMySales(showMySales: false));
                    // chatState.updateShowMySales(false);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: !chatState.isShowMySales ? 2 : 1,
                          color: !chatState.isShowMySales
                              ? ColorResources.blue
                              : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'my_purchases'.tr,
                      style: textSm.copyWith(
                          color: !chatState.isShowMySales
                              ? ColorResources.blue
                              : ColorResources.gray),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context
                        .read<ChatBloc>()
                        .add(const UpdateShowMySales(showMySales: true));
                    // chatState.updateShowMySales(true);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: chatState.isShowMySales ? 2 : 1,
                          color: chatState.isShowMySales
                              ? ColorResources.blue
                              : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'my_sales'.tr,
                      style: textSm.copyWith(
                          color: chatState.isShowMySales
                              ? ColorResources.blue
                              : ColorResources.gray),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
