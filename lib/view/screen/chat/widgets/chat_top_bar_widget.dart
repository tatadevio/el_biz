import 'package:el_biz/controller/chat_controller.dart';
import 'package:flutter/material.dart';
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
    return GetBuilder<ChatController>(builder: (chatController) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    chatController.updateShowAllMessages(true);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: chatController.isShowAllMessage ? 2 : 1,
                          color: chatController.isShowAllMessage ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Все сообщения',
                      style: textSm.copyWith(color: chatController.isShowAllMessage ? ColorResources.blue : ColorResources.gray),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    chatController.updateShowAllMessages(false);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: !chatController.isShowAllMessage ? 2 : 1,
                          color: !chatController.isShowAllMessage ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Непрочитанные',
                      style: textSm.copyWith(color: !chatController.isShowAllMessage ? ColorResources.blue : ColorResources.gray),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: searchController,
            hintColor: 'Поиск в чатах',
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
