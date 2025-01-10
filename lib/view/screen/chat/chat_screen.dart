import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_top_bar_widget.dart';
import 'package:el_biz/view/screen/chat/widgets/contract_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child:
              BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
            return Container(
              decoration:
                  const BoxDecoration(color: ColorResources.backgroundColor),
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
                            context
                                .read<ChatBloc>()
                                .add(const UpdateShowChat(showChat: true));
                            // chatState.updateShowChat(true);
                          },
                          child: Container(
                            width: width * 0.45,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color:
                                    chatState.isShowChat ? Colors.white : null,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: chatState.isShowChat
                                    ? [
                                        ColorResources.shadow1,
                                        ColorResources.shadow2
                                      ]
                                    : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'messages'.tr,
                                  style: button16.copyWith(
                                      color: chatState.isShowChat
                                          ? ColorResources.darkGray
                                          : ColorResources.gray),
                                ),
                                //Unseen Count
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<ChatBloc>()
                                .add(const UpdateShowChat(showChat: false));
                            // chatState.updateShowChat(false);
                          },
                          child: Container(
                            width: width * 0.45,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color:
                                    !chatState.isShowChat ? Colors.white : null,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: !chatState.isShowChat
                                    ? [
                                        ColorResources.shadow1,
                                        ColorResources.shadow2
                                      ]
                                    : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'treaty'.tr,
                                  style: button16.copyWith(
                                      color: !chatState.isShowChat
                                          ? ColorResources.darkGray
                                          : ColorResources.gray),
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
                    if (chatState.isShowChat) ...[
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
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) => const SizedBox(),
        builder: (context, chatState) {
          if (chatState.isShowChat) {
            if (chatState.isShowAllMessage) {
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
            if (chatState.isShowMySales) {
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
        },
      ),

      // BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      //   if (chatState.isShowChat) {
      //     if (chatState.isShowAllMessage) {
      //       //showing all messages
      //       return ListView.builder(
      //         itemCount: 10,
      //         itemBuilder: (context, index) {
      //           return ChatTile(
      //             unSeen: index % 3 == 0,
      //             isMessage: true,
      //           );
      //         },
      //       );
      //     } else {
      //       //showing unread messages
      //       return ListView.builder(
      //         itemCount: 4,
      //         itemBuilder: (context, index) {
      //           return const ChatTile(
      //             unSeen: true,
      //             isMessage: true,
      //           );
      //         },
      //       );
      //     }
      //   } else {
      //     if (chatState.isShowMySales) {
      //       //showing my sales
      //       return ListView.builder(
      //         itemCount: 10,
      //         itemBuilder: (context, index) {
      //           return const ChatTile(
      //             isMessage: false,
      //           );
      //         },
      //       );
      //     } else {
      //       //showing my purchases
      //       return ListView.builder(
      //         itemCount: 10,
      //         itemBuilder: (context, index) {
      //           return const ChatTile(
      //             isMessage: false,
      //           );
      //         },
      //       );
      //     }
      //   }
      // }),
    );
  }
}
