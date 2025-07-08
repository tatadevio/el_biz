import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_textfield.dart';

class ChatTopBarWidget extends StatefulWidget {
  const ChatTopBarWidget({super.key});

  @override
  State<ChatTopBarWidget> createState() => _ChatTopBarWidgetState();
}

class _ChatTopBarWidgetState extends State<ChatTopBarWidget> {
  final TextEditingController productSearchController = TextEditingController();
  final TextEditingController tenderSearchController = TextEditingController();
  Timer? _productSearchTimer;
  Timer? _tenderSearchTimer;

  @override
  void dispose() {
    _productSearchTimer?.cancel();
    _tenderSearchTimer?.cancel();
    productSearchController.dispose();
    tenderSearchController.dispose();
    super.dispose();
  }

  void _onProductSearchChanged(String query) {
    _productSearchTimer?.cancel();
    _productSearchTimer = Timer(const Duration(milliseconds: 300), () {
      context
          .read<ChatBloc>()
          .add(SearchChatProducts(query: query, currentPage: 1));
    });
  }

  void _onTenderSearchChanged(String query) {
    _tenderSearchTimer?.cancel();
    _tenderSearchTimer = Timer(const Duration(milliseconds: 300), () {
      context
          .read<ChatBloc>()
          .add(SearchChatTenders(query: query, currentPage: 1));
    });
  }

  void _clearProductSearch() {
    productSearchController.clear();
    context.read<ChatBloc>().add(SearchChatProducts(query: '', currentPage: 1));
  }

  void _clearTenderSearch() {
    tenderSearchController.clear();
    context.read<ChatBloc>().add(SearchChatTenders(query: '', currentPage: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.read<ChatBloc>().add(
                        const UpdateShowAllMessages(showAllMessages: true));
                    // chatState.updateShowAllMessages(true);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: chatState.isShowAllMessage ? 2 : 1,
                          color: chatState.isShowAllMessage
                              ? ColorResources.blue
                              : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'goods'.tr,
                      // 'all_messages'.tr,
                      style: textSm.copyWith(
                          color: chatState.isShowAllMessage
                              ? ColorResources.blue
                              : ColorResources.gray),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.read<ChatBloc>().add(
                        const UpdateShowAllMessages(showAllMessages: false));
                    // chatState.updateShowAllMessages(false);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: !chatState.isShowAllMessage ? 2 : 1,
                          color: !chatState.isShowAllMessage
                              ? ColorResources.blue
                              : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'tenders'.tr,
                      // 'unread'.tr,
                      style: textSm.copyWith(
                          color: !chatState.isShowAllMessage
                              ? ColorResources.blue
                              : ColorResources.gray),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (chatState.isShowAllMessage)
            CustomTextField(
              controller: productSearchController,
              hintColor: 'search_in_chats'.tr,
              inputType: TextInputType.text,
              leading: Images.svgSearch,
              readOnly: false,
              onChanged: _onProductSearchChanged,
              suffix: IconButton(
                onPressed: _clearProductSearch,
                icon: const Icon(Icons.close),
              ),
            ),
          if (!chatState.isShowAllMessage) ...[
            CustomTextField(
              controller: tenderSearchController,
              hintColor: 'search_in_tenders'.tr,
              inputType: TextInputType.text,
              leading: Images.svgSearch,
              readOnly: false,
              onChanged: _onTenderSearchChanged,
              suffix: IconButton(
                onPressed: _clearTenderSearch,
                icon: const Icon(Icons.close),
              ),
            ),
          ]
        ],
      );
    });
  }
}
