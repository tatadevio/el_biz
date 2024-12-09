import 'package:el_biz/controller/chat_controller.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_top_bar_widget.dart';
import 'package:el_biz/view/screen/chat/widgets/contract_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'widgets/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'.tr),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: GetBuilder<ChatController>(builder: (chatController) {
            return Container(
              decoration: const BoxDecoration(color: ColorResources.backgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            chatController.updateShowChat(true);
                          },
                          child: Container(
                            width: width * 0.45,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: chatController.isShowChat ? Colors.white : null, borderRadius: BorderRadius.circular(6), boxShadow: chatController.isShowChat ? [ColorResources.shadow1, ColorResources.shadow2] : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'messages'.tr,
                                  style: button16.copyWith(color: chatController.isShowChat ? ColorResources.darkGray : ColorResources.gray),
                                ),
                                //Unseen Count
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            chatController.updateShowChat(false);
                          },
                          child: Container(
                            width: width * 0.45,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: !chatController.isShowChat ? Colors.white : null, borderRadius: BorderRadius.circular(6), boxShadow: !chatController.isShowChat ? [ColorResources.shadow1, ColorResources.shadow2] : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'treaty'.tr,
                                  style: button16.copyWith(color: !chatController.isShowChat ? ColorResources.darkGray : ColorResources.gray),
                                ),
                                //Unseen Count
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (chatController.isShowChat) ...[
                      const ChatTopBarWidget(),
                    ] else ...[
                      const ContractTopBar(),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      body: GetBuilder<ChatController>(builder: (chatController) {
        if (chatController.isShowChat) {
          if (chatController.isShowAllMessage) {
            //showing all messages
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatTile(
                  unSeen: index % 3 == 0,
                  isMessage: true,
                );
              },
            );
          } else {
            //showing unread messages
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return const ChatTile(
                  unSeen: true,
                  isMessage: true,
                );
              },
            );
          }
        } else {
          if (chatController.isShowMySales) {
            //showing my sales
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ChatTile(
                  isMessage: false,
                );
              },
            );
          } else {
            //showing my purchases
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ChatTile(
                  isMessage: false,
                );
              },
            );
          }
        }
      }),
    );
  }
}
