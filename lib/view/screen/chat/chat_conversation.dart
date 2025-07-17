import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/data/model/response/userinfo_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/widgets/new_message_widget.dart';
import 'package:el_biz/view/screen/contracts/conditions_creating_contract_screen.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../data/model/response/chat/chat_list_model.dart';
import '../../../data/model/response/chat/chat_list_model.dart' as user;
import '../../../data/model/response/tender/tender_item_model.dart';
import '../../../helper/send_notification.dart';
import '../auth/login.dart';
import '../select_tender/select_tender_screen.dart';
import 'widgets/message_item.dart';

class ChatConversation extends StatefulWidget {
  final ChatItem? chatItem;
  final bool isFirstMessage;
  // final bool isSeller;
  final String? chatId;
  // final String receiverId;
  // final String senderId;
  // final String firebaseChatId;
  // final String chatId;
  // final int userUnread;
  // final int productUserId;
  // final int ownerUnread;
  // final String productName;
  // final String productPrice;
  // final ProductListItem product;
  // final String type;
  // final String
  //     productId; // getting to init chat only coming form the product detail screen
  // // final String tenderId;
  // final String
  //     tenderId; // getting to init tender chat from tender detail screen
  // final TenderItem? tender;
  // final int companyId;
  const ChatConversation({
    super.key,
    required this.chatItem,
    // required this.isSeller,
    required this.isFirstMessage,
    this.chatId,
    // this.receiverId = '',
    // required this.senderId,
    // // required this.productId,
    // this.firebaseChatId = '',
    // this.chatId = '',
    // this.userUnread = 0,
    // this.ownerUnread = 0,
    // this.productUserId = 0,
    // required this.productName,
    // required this.productPrice,
    // required this.product,
    // this.type = 'product',
    // this.tenderId = '0',
    // this.tender,
    // required this.companyId,
    // this.productId = '0',
  });

  @override
  State<ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  // late Stream<QuerySnapshot> _messagesStream;

  List<DocumentSnapshot> messages = [];
  bool isLoading = false;
  bool hasMore = true;
  DocumentSnapshot? lastDocument;
  final ScrollController _scrollController = ScrollController();
  String? _latestFetchedMessageId;
  bool showScrollToBottomButton = false;
  user.User? senderUser;
  user.User? receiverUser;

  String chatId = '';
  ChatItem? chatItem;
  @override
  void initState() {
    // _messagesStream = _createOptimizedMessageStream();
    if (!context.read<AuthBloc>().state.isLoggedIn) {
      Get.offAll(() => LoginScreen());
    }
    if (widget.chatItem == null) {
      getAllDataWithChatItem();
    } else {
      chatItem = widget.chatItem;

      _fetchMessages().then((_) {
        _listenToNewMessages(); // Start listening only after first fetch
      });

      _scrollController.addListener(() {
        // Since reverse: true, pixels == minScrollExtent is bottom (latest messages)
        bool isAtBottom = _scrollController.position.pixels <=
            _scrollController.position.minScrollExtent + 300;

        if (isAtBottom && showScrollToBottomButton) {
          setState(() {
            showScrollToBottomButton = false;
          });
        } else if (!isAtBottom && !showScrollToBottomButton) {
          setState(() {
            showScrollToBottomButton = true;
          });
        }
        // get more messages
        if (_scrollController.position.pixels >
                _scrollController.position.maxScrollExtent - 300 &&
            !isLoading &&
            hasMore) {
          _fetchMessages();
        }
      });

      Future.delayed(Duration.zero, () {
        _listenToReceiverSeenStatus();
        updateChatId();
        updateUser();
      });
    }

    super.initState();
  }

  void getAllDataWithChatItem() async {
    final completer = Completer<ChatItem>();

    context.read<ChatBloc>().add(FetchChatItemFromChatId(
          chatId: widget.chatId!,
          completer: completer,
        ));

    try {
      final newChatItem = await completer.future;
      // Do something with chatItem
      // _initializeChat(chatItem);
      chatItem = newChatItem;
      ;

      _fetchMessages().then((_) {
        _listenToNewMessages(); // Start listening only after first fetch
      });

      _scrollController.addListener(() {
        // Since reverse: true, pixels == minScrollExtent is bottom (latest messages)
        bool isAtBottom = _scrollController.position.pixels <=
            _scrollController.position.minScrollExtent + 300;

        if (isAtBottom && showScrollToBottomButton) {
          setState(() {
            showScrollToBottomButton = false;
          });
        } else if (!isAtBottom && !showScrollToBottomButton) {
          setState(() {
            showScrollToBottomButton = true;
          });
        }
        // get more messages
        if (_scrollController.position.pixels >
                _scrollController.position.maxScrollExtent - 300 &&
            !isLoading &&
            hasMore) {
          _fetchMessages();
        }
      });

      Future.delayed(Duration.zero, () {
        _listenToReceiverSeenStatus();
        updateChatId();
        updateUser();
      });
    } catch (e) {
      print("Error fetching chat item: $e");
      Get.back();
    }
  }

  updateUser() {
    if (chatItem?.user?.id ==
        context.read<UserBloc>().state.userInfo?.data?.id) {
      senderUser = chatItem?.user;
      receiverUser = chatItem?.company?.owner;
    } else {
      senderUser = chatItem?.company?.owner;
      receiverUser = chatItem?.user;
    }
    // if (chatItem?.type == 'product') {
    //   if (chatItem?.user?.id ==
    //       context.read<UserBloc>().state.userInfo?.data?.id) {
    //     senderUser = chatItem?.user;
    //     receiverUser = chatItem?.product?.user;
    //   } else {
    //     senderUser = chatItem?.product?.user;
    //     receiverUser = chatItem?.user;
    //   }
    // } else {
    //   if (chatItem?.user?.id ==
    //       context.read<UserBloc>().state.userInfo?.data?.id) {
    //     senderUser = chatItem?.user;
    //     receiverUser = chatItem?.tender?.company?.owner;
    //   } else {
    //     senderUser = chatItem?.tender?.company?.owner;
    //     receiverUser = chatItem?.user;
    //   }
    // }
  }

  updateChatId() async {
    int myUserId = context.read<UserBloc>().state.userInfo!.data!.id!;
    if (chatItem?.chatId != '' && widget.isFirstMessage == false) {
      setState(() {
        chatId = chatItem?.chatId.toString() ?? '';
      });

      context.read<ChatBloc>().add(UpdateUnReadCount(
          chatId: chatItem?.chatId.toString() ?? '',
          userCount: chatItem?.product?.user?.id != myUserId
              ? 0
              : chatItem?.userUnreadCount ?? 0,
          ownerCount: chatItem?.company?.owner?.id == myUserId
              ? 0
              : chatItem?.productOwnerUnreadCount ?? 0));
    } else {
      final completer = Completer<String>();

      context.read<ChatBloc>().add(
            SendMessage(
                productId: chatItem?.type == 'tender'
                    ? '0'
                    : chatItem?.product?.id.toString() ?? '0',

                // widget.productId,
                type: chatItem?.type ?? '',
                tenderId: chatItem?.type == 'tender'
                    ? chatItem?.tender?.id.toString() ?? '0'
                    : '0',
                // widget.tenderId,
                completer: completer),
          );

      try {
        final newChatId = await completer.future;
        setState(() {
          chatId = newChatId;
        });
        print("Chat ID: $chatId");
      } catch (e) {
        print("Failed to get chat ID: $e");
      }
    }
  }

  Future<void> _fetchMessages() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('chat')
        .doc(chatItem?.firebaseChatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(10);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    try {
      QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        if (lastDocument == null) {
          _latestFetchedMessageId = snapshot.docs.first.id;
        }

        lastDocument = snapshot.docs.last;
        messages.addAll(snapshot.docs);
      } else {
        hasMore = false; // No more messages to fetch
      }
    } catch (e) {
      debugPrint("Error fetching messages: $e");
    }

    // Ensure loading state is reset no matter what
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _listenToNewMessages() {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(chatItem?.firebaseChatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final newMessage = snapshot.docs.first;

        if (newMessage.id == _latestFetchedMessageId) {
          // Skip the first real-time message that's already been fetched
          _latestFetchedMessageId = null; // Reset to allow future live messages
          return;
        }

        // Check if it's already in the list
        bool alreadyExists = messages.any((msg) => msg.id == newMessage.id);
        if (!alreadyExists) {
          setState(() {
            messages.insert(0, newMessage); // Add new incoming message
          });
        }
      }
    });
  }

  void _markMessageAsSeen(String messageId) async {
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('chat')
        .doc(chatItem?.firebaseChatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'read': true,
      'seen_at': FieldValue.serverTimestamp(),
      'seen_by': currentUserId,
    });
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(chatItem?.firebaseChatId)
        .update({
      'read': true,
      'seen_at': FieldValue.serverTimestamp(),
      'seen_by': currentUserId,
    });
  }

  void _listenToReceiverSeenStatus() {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(chatItem?.firebaseChatId)
        .collection('messages')
        .where('sender_type', isEqualTo: "user")
        .where('read', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        final messageId = doc.id;
        final alreadyUpdated =
            messages.any((msg) => msg.id == messageId && msg['read'] == true);

        if (!alreadyUpdated) {
          setState(() {
            final index = messages.indexWhere((msg) => msg.id == messageId);
            if (index != -1) {
              messages[index] = doc; // Replace the message with updated one
            }
          });
        }
      }
    });
  }

  void updateLastMessage(
      ProductListItem? selectedProduct, TenderItem? selectedTender) {
    if (selectedProduct == null && selectedTender == null) {
      print("No product or tender selected to update last message.");
      return;
    }
    try {
      if (selectedProduct != null) {
        context.read<ChatBloc>().add(UpdateLastMessage(
              chatId: chatItem?.chatId.toString() ?? '',
              message: '🛍 ${selectedProduct.name}',
              userCount: 0,
              ownerCount: 0,
              type: chatItem?.type ?? '',
            ));
      } else {
        context.read<ChatBloc>().add(UpdateLastMessage(
              chatId: chatItem?.chatId.toString() ?? '',
              message: '🛍 ${selectedTender?.title}',
              userCount: 0,
              ownerCount: 0,
              type: chatItem?.type ?? '',
            ));
      }
    } catch (e) {
      print("Error updating last message: $e");
    }

    try {
      context.read<ProductBloc>().add(ClearSelectedProduct());
    } catch (e) {
      print("Error clearing product: $e");
    }
  }

  void clearSelectedProduct() {
    try {
      context.read<ProductBloc>().add(ClearSelectedProduct());
    } catch (e) {
      print("Error clearing product: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () {},
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          leading: CustomImage(
              image: chatItem?.type == 'product'
                  ? chatItem?.product?.image ?? ''
                  : chatItem?.tender?.image ?? '',
              height: 32,
              width: 32,
              radius: 5.3),
          title: Text(
            chatItem?.type == 'product'
                ? chatItem?.product?.name ?? ''
                : chatItem?.tender?.title ?? '',
            // widget.productName,
            // 'Садовая мебель Loft',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          subtitle: Text(
            chatItem?.type == 'product'
                ? '${chatItem?.product?.price} сом/шт'
                : "${chatItem?.tender?.budgetFrom} - ${chatItem?.tender?.budgetTo} сом",
            style: body14.copyWith(color: ColorResources.blue),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Column(
            children: [
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (context.read<UserBloc>().state.userInfo?.data?.id ==
                          chatItem?.user?.id) ...[
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      Expanded(
                        child: CustomBorderButton(
                          height: 36,
                          width: Get.width,
                          padding: const EdgeInsets.all(0),
                          border:
                              Border.all(width: 1, color: ColorResources.blue),
                          borderRadius: BorderRadius.circular(8),
                          boxShaow: const [ColorResources.shadow1],
                          onTap: chatItem?.type == 'tender'
                              ? () {
                                  Get.to(() => SelectTenderScreen(
                                        alreadySelectedItems: [],
                                        onSelect: (selectedTender) async {
                                          UserData? myUser = context
                                              .read<UserBloc>()
                                              .state
                                              .userInfo
                                              ?.data;
                                          if (selectedTender != null) {
                                            Map<String, dynamic> sendMessage = {
                                              "read": false,
                                              "sender_type": context
                                                          .read<UserBloc>()
                                                          .state
                                                          .userInfo
                                                          ?.data
                                                          ?.id !=
                                                      chatItem?.user?.id
                                                  ? 'seller'
                                                  : 'user',

                                              "text": '',
                                              "link": '',
                                              "isProduct": false,
                                              "isTender": true,
                                              "tender": selectedTender.toJson(),
                                              "type": 'tender',
                                              "product": null,
                                              'timestamp':
                                                  FieldValue.serverTimestamp(),
                                              'last_fcm': '',
                                              // userModel.fcmToken ?? '',
                                              "sender": {
                                                "id": senderUser?.id,
                                                "name": myUser?.name ?? '',
                                                "image": myUser?.image ?? '',
                                                "phone": myUser?.phone ?? '',
                                                "email": myUser?.email ?? '',
                                              },
                                              "receiver": {
                                                "id": receiverUser?.id,
                                              },
                                            };
                                            await FirebaseFirestore.instance
                                                .collection('chat')
                                                .doc(widget
                                                    .chatItem?.firebaseChatId)
                                                .collection('messages')
                                                .add(sendMessage);
                                            await FirebaseFirestore.instance
                                                .collection('chat')
                                                .doc(widget
                                                    .chatItem?.firebaseChatId)
                                                .set(sendMessage);
                                            updateLastMessage(
                                                null, selectedTender);
                                            // clearSelectedProduct();
                                            context
                                                .read<TendersBloc>()
                                                .add(ClearSelectedTender());
                                            sendNotificationToToken(
                                                title: myUser?.name ?? '',
                                                // "New Message",
                                                message:
                                                    '🛍 ${selectedTender.title}',
                                                fcmToken:
                                                    receiverUser?.fcmToken ??
                                                        await getFcmToken(),
                                                chatId: widget.chatId,
                                                senderId:
                                                    senderUser?.id.toString() ??
                                                        '',
                                                type:
                                                    "chat-${widget.chatItem?.type}");

                                            Get.back();
                                          }
                                        },
                                      ));
                                  // send notification to the receiver
                                  // sendNotification(widget.receiverId, widget.senderId, widget.type);
                                }
                              : () {
                                  context
                                      .read<ProductBloc>()
                                      .add(const UpdateShowCategories(false));
                                  // clearSelectedProduct();
                                  UserData? myUser = context
                                      .read<UserBloc>()
                                      .state
                                      .userInfo
                                      ?.data;
                                  Get.to(
                                    () => ProductScreen(
                                      isSelectProduct: true,
                                      onSendProduct: () async {
                                        ProductListItem? selectedProduct =
                                            context
                                                .read<ProductBloc>()
                                                .state
                                                .selectedProduct;
                                        Map<String, dynamic> sendMessage = {
                                          "read": false,
                                          "sender_type": context
                                                      .read<UserBloc>()
                                                      .state
                                                      .userInfo
                                                      ?.data
                                                      ?.id !=
                                                  chatItem?.user?.id
                                              ? 'seller'
                                              : 'user',

                                          "text": '',
                                          "link": '',
                                          "isProduct": true,
                                          "isTender": false,
                                          "tender": null,
                                          "type": 'product',
                                          "product": selectedProduct?.toJson(),
                                          'timestamp':
                                              FieldValue.serverTimestamp(),
                                          'last_fcm': '',
                                          // userModel.fcmToken ?? '',
                                          "sender": {
                                            "id": senderUser?.id,
                                            "name": myUser?.name ?? '',
                                            "image": myUser?.image ?? '',
                                            "phone": myUser?.phone ?? '',
                                            "email": myUser?.email ?? '',
                                          },
                                          "receiver": {
                                            "id": receiverUser?.id,
                                          },
                                        };
                                        await FirebaseFirestore.instance
                                            .collection('chat')
                                            .doc(chatItem?.firebaseChatId)
                                            .collection('messages')
                                            .add(sendMessage);
                                        await FirebaseFirestore.instance
                                            .collection('chat')
                                            .doc(chatItem?.firebaseChatId)
                                            .set(sendMessage);
                                        updateLastMessage(
                                            selectedProduct, null);
                                        sendNotificationToToken(
                                            title: myUser?.name ?? '',
                                            // "New Message",
                                            message:
                                                '🛍 ${selectedProduct?.name ?? ''}',
                                            fcmToken: receiverUser?.fcmToken ??
                                                await getFcmToken(),
                                            chatId: widget.chatId,
                                            senderId:
                                                senderUser?.id.toString() ?? '',
                                            type:
                                                "chat-${widget.chatItem?.type}");
                                        clearSelectedProduct();

                                        Get.back();
                                        // send isProduct message...
                                      },
                                    ),
                                  );
                                  // send notification to the receiver
                                  // sendNotification(widget.receiverId, widget.senderId, widget.type);
                                },
                          child: Text(
                            chatItem?.type == 'tender'
                                ? 'select_tender'.tr
                                : 'select_products'.tr,
                            style: textSm.copyWith(color: ColorResources.blue),
                          ),
                        ),
                      ),
                      if (context.read<UserBloc>().state.userInfo?.data?.id !=
                          chatItem?.user?.id) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap:

                                //  widget.type == 'tender'
                                //     ? () {

                                //       }
                                //     :

                                () {
                              print("this is buyer id = ${receiverUser?.id}");
                              context
                                  .read<AgreementBloc>()
                                  .add(GetPaymentMethod(currentPage: 1));
                              Get.to(() => ConditionsCreatingContractScreen(
                                    product:
                                        chatItem?.product ?? ProductListItem(),
                                    tenderItem:
                                        chatItem?.tender ?? TenderItem(),
                                    buyerId: receiverUser?.id.toString() ?? '',
                                    type: chatItem?.type ?? '',
                                    // tenderId:
                                    //     widget.tender?.id.toString() ?? '0',
                                    // productId: widget.productId,
                                    companyId: chatItem?.company?.id ?? 0,
                                  ));

                              // there have to send the company id
                            },
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: ColorResources.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorResources.green),
                                boxShadow: const [ColorResources.shadow1],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Images.svgPlus),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'agreement'.tr,
                                    style: textSm.copyWith(
                                        color: ColorResources.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
            if (chatState.isLoading) {
              return Expanded(
                  child: const Center(child: CircularProgressIndicator()));
            }
            return Expanded(
              child: messages.isEmpty && !isLoading
                  ? Center(
                      child: Text(
                        'no_messages'.tr,
                        style: body14.copyWith(color: ColorResources.gray),
                      ),
                    )
                  : messages.isEmpty && isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Stack(
                          children: [
                            ListView.builder(
                              controller: _scrollController,
                              reverse: true,
                              itemCount: messages.length + (isLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == messages.length) {
                                  // Show loading indicator at the bottom
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }

                                var messageData = messages[index];
                                bool isMe =
                                    messageData['sender']['id'].toString() ==
                                        senderUser?.id.toString();

                                if (!isMe && !messageData['read']) {
                                  _markMessageAsSeen(messageData.id);
                                }

                                // Check if we need to show a date header
                                bool showDateHeader = false;
                                String dateHeader = '';

                                if (messageData['timestamp'] != null) {
                                  DateTime messageDate =
                                      (messageData['timestamp'] as Timestamp)
                                          .toDate();
                                  DateTime now = DateTime.now();
                                  DateTime yesterday =
                                      now.subtract(const Duration(days: 1));

                                  // Check if this is the first message or if the date changed from previous message
                                  if (index == messages.length - 1 ||
                                      messages[index + 1]['timestamp'] ==
                                          null ||
                                      messageDate.day !=
                                          (messages[index + 1]['timestamp']
                                                  as Timestamp)
                                              .toDate()
                                              .day) {
                                    showDateHeader = true;
                                    if (messageDate.year == now.year &&
                                        messageDate.month == now.month &&
                                        messageDate.day == now.day) {
                                      dateHeader = 'Today';
                                    } else if (messageDate.year ==
                                            yesterday.year &&
                                        messageDate.month == yesterday.month &&
                                        messageDate.day == yesterday.day) {
                                      dateHeader = 'Yesterday';
                                    } else {
                                      dateHeader =
                                          '${messageDate.day} ${DateFormat('MMMM').format(messageDate)} ${messageDate.year}';
                                    }
                                  }
                                }

                                return Column(
                                  children: [
                                    if (showDateHeader)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorResources.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          child: Text(
                                            dateHeader,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ChatMessageWidget1(
                                      data:
                                          messageData as QueryDocumentSnapshot,
                                      isMe: isMe,
                                    ),
                                  ],
                                );
                              },
                            ),
                            if (showScrollToBottomButton)
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    _scrollController.animateTo(
                                      _scrollController.position
                                          .minScrollExtent, // This is the bottom in reverse mode
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorResources.primary,
                                    ),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
            );
          }),
          NewMessageWidget(
            firebaseChatId: chatItem?.firebaseChatId ?? '',
            chatId: chatId,
            receiverId: receiverUser?.id.toString() ?? '',
            senderId: senderUser?.id.toString() ?? '',
            productId: chatItem?.type == 'tender'
                ? chatItem?.tender?.id.toString() ?? '0'
                : chatItem?.product?.id.toString() ?? '0',
            isFirstMessage: widget.isFirstMessage,
            userUnread: chatItem?.userUnreadCount ?? 0,
            ownerUnread: chatItem?.productOwnerUnreadCount ?? 0,
            productUserId: chatItem?.product?.user?.id ?? 0,
            type: chatItem?.type ?? '',
            receiverFcmToken: receiverUser?.fcmToken,
          ),
        ],
      ),
    );
  }

  Future<String> getFcmToken() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUser?.id.toString() ?? '')
        .get();
    return userDoc.data()?['fcmToken'] ?? '';
  }
}
