import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
  final TextEditingController searchController = TextEditingController();
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
          CustomTextField(
            controller: searchController,
            hintColor: 'search_in_chats'.tr,
            inputType: TextInputType.text,
            leading: Images.svgSearch,
            readOnly: false,
            suffix: IconButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  searchController.clear();
                }
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      );
    });
  }
}
