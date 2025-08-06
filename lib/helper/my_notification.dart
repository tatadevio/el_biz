import 'dart:io';

import 'package:el_biz/view/screen/chat/chat_conversation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../bloc/chat/chat_bloc.dart';
import '../bloc/company_detail/company_detail_bloc.dart';
import '../bloc/contracts/contracts_bloc.dart';
import '../bloc/notification/notification_bloc.dart';
import '../bloc/product_detail/product_detail_bloc.dart';
import '../bloc/tender_detail/tender_detail_bloc.dart';
import '../utils/appConstant.dart';
import '../view/screen/company/company_page_screen.dart';
import '../view/screen/contracts/contract_page_screen.dart';
import '../view/screen/product_detail/product_detail_screen.dart';
import '../view/screen/tender/tender_detail_screen.dart';

// Global notification service to handle notification clicks safely
class NotificationService {
  static void handleNotificationClick(
      String status, String id, String notificationId,
      [BuildContext? context]) {
    print('🔔 Handling notification click - Type: $status, ID: $id');

    // Mark notification as read if context is available and valid
    if (context != null) {
      try {
        context.read<NotificationBloc>().add(ReadNotification(notificationId));
      } catch (e) {
        print('⚠️ Error marking notification as read: $e');
      }
    }

    // Handle navigation based on notification type
    try {
      switch (status) {
        case 'company':
          _handleCompanyNotification(id);
          break;
        case 'product':
          _handleProductNotification(id);
          break;
        case 'tender':
          _handleTenderNotification(id);
          break;
        case 'contract_creation':
        case 'contract_signing':
        case 'payment':
        case 'contract_status':
          print(
              '🔍 DEBUG: NotificationService handling contract notification with ID = $id');
          _handleContractNotification(id);
          break;
        default:
          print('⚠️ Unknown notification type: $status');
      }
    } catch (e) {
      print('❌ Error handling notification click: $e');
    }
  }

  static void _handleCompanyNotification(String id) {
    try {
      // Check if bloc is available before using it
      if (Get.isRegistered<CompanyDetailBloc>()) {
        Get.find<CompanyDetailBloc>().add(GetCompanyDetail(id));
        
      }
      Get.to(() => CompanyPageScreen(isCompany: true));
    } catch (e) {
      print('❌ Error handling company notification: $e');
      // Fallback navigation without bloc
      Get.to(() => CompanyPageScreen(isCompany: true));
    }
  }

  static void _handleProductNotification(String id) {
    try {
      // Check if bloc is available before using it
      if (Get.isRegistered<ProductDetailBloc>()) {
        Get.find<ProductDetailBloc>().add(GetProductDetail(id));
      }
      Get.to(() => ProductDetailScreen(isProduct: true));
    } catch (e) {
      print('❌ Error handling product notification: $e');
      // Fallback navigation without bloc
      Get.to(() => ProductDetailScreen(isProduct: true));
    }
  }

  static void _handleTenderNotification(String id) {
    try {
      // Check if bloc is available before using it
      if (Get.isRegistered<TenderDetailBloc>()) {
        Get.find<TenderDetailBloc>().add(GetTenderDetail(tenderId: id));
      }
      Get.to(() => TenderDetailScreen(tenderName: ''));
    } catch (e) {
      print('❌ Error handling tender notification: $e');
      // Fallback navigation without bloc
      Get.to(() => TenderDetailScreen(tenderName: ''));
    }
  }

  static void _handleContractNotification(String id) {
    try {
      // Check if bloc is available before using it
      if (Get.isRegistered<ContractsBloc>()) {
        Get.find<ContractsBloc>().add(GetContractDetail(contractId: id));
      }
      Get.to(() => ContractPageScreen(contractId: int.parse(id)));
    } catch (e) {
      print('❌ Error handling contract notification: $e');
      // Fallback navigation without bloc
      Get.to(() => ContractPageScreen(contractId: int.parse(id)));
    }
  }
}

// Top-level function for background notification handling
@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) async {
  // Handle background notification response here if needed
  print('Background notification received: ${notificationResponse.payload}');
}

class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      BuildContext context) async {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var iOSInitialize = const DarwinInitializationSettings(
        requestBadgePermission: true,
        requestAlertPermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true);
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse? notificationResponse) async {
        final payload = notificationResponse?.payload;
        try {
          if (payload != null && payload.isNotEmpty) {
            print('payload is : $payload');
            List<String> result = payload.split(',');
            String id = result[0];
            String type = result[1];
            // String receiverid = result[2];
            String contractId = result[3];
            String notificationId = result[4];
            print("payload is $id  and $type");
            if (type == 'chat-product') {
              // add api to get chat detail
              Get.to(() => ChatConversation(
                    chatId: id,
                    // isSeller: true,
                    isFirstMessage: false,
                    chatItem: null,
                  ));
            } else if (type == 'chat-tender') {
              Get.to(() => ChatConversation(
                    chatId: id,
                    // isSeller: true,
                    isFirstMessage: false,
                    chatItem: null,
                  ));
            } else {
              NotificationService.handleNotificationClick(
                  type, contractId, notificationId, context);
            }

            /*Get.find<BooksDetailController>().bookDetail(payload.toString());
          Get.to(BooksDetails());*/
            //Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
          } else {}
        } catch (e) {}
        return;
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      //showShortToast("Background message ${message?.data}");
      print("initial message  i am coming = ${message?.data}");
      if (message?.data != null) {
        print(message?.data);

        String type = message?.data['notification_type'];
        String id = message?.data['chatId'];
        if (type == 'chat-product') {
          // add api to get chat detail
          print('this is the product chat id = $id');
          Get.to(() => ChatConversation(
                chatId: id,
                // isSeller: true,
                isFirstMessage: false,
                chatItem: null,
              ));
        } else if (type == 'chat-tender') {
          print('this is the tender chat id = $id');
          Get.to(() => ChatConversation(
                chatId: id,
                // isSeller: true,
                isFirstMessage: false,
                chatItem: null,
              ));
        } else {
          String notificationId = message?.data['notification_id'];
          String contractId = message?.data['contract_id'] ??
              message?.data['product_id'] ??
              message?.data['tender_id'];
          NotificationService.handleNotificationClick(
              type, contractId, notificationId, context);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: ${message.data}");
      print("onMessage: ${message.notification}");

      String type = message.data['notification_type'];
      print('on message listentype is $type');
      if (type == 'chat-product') {
        context
            .read<ChatBloc>()
            .add(GetChatProductList(currentPage: 1, reload: false));
      } else if (type == 'chat-tender') {
        context
            .read<ChatBloc>()
            .add(GetChatTenderList(currentPage: 1, reload: false));
      } else {
        context.read<NotificationBloc>().add(GetNotification(1));

        if (type == 'contract_status' ||
            type == 'contract_signing' ||
            type == 'payment') {
          String? contractId = message.data['contract_id'];
          print('🔍 DEBUG: Notification type = $type');
          print('🔍 DEBUG: Contract ID from notification = $contractId');
          print('🔍 DEBUG: Full message data = ${message.data}');

          if (contractId != null) {
            // Check if user is already on ContractPageScreen
            bool isOnContractScreen =
                Get.currentRoute.contains('ContractPageScreen');
            print(
                '🔍 DEBUG: Is user on ContractPageScreen? = $isOnContractScreen');
            print('🔍 DEBUG: Current route = ${Get.currentRoute}');

            if (isOnContractScreen) {
              // Check if the contract ID matches the current contract detail
              final contractsState = context.read<ContractsBloc>().state;
              final currentContractDetail = contractsState.contractDetail;

              print(
                  '🔍 DEBUG: Current contract detail = $currentContractDetail');
              print(
                  '🔍 DEBUG: Current contract detail ID = ${currentContractDetail?.id}');
              print('🔍 DEBUG: Notification contract ID = $contractId');
              print(
                  '🔍 DEBUG: IDs match? = ${currentContractDetail?.id.toString() == contractId}');

              if (currentContractDetail != null &&
                  currentContractDetail.id.toString() == contractId) {
                // User is already viewing the same contract, no need to call API
                print(
                    '🔔 User already viewing contract $contractId, skipping API call');
                context
                    .read<ContractsBloc>()
                    .add(GetContractDetail(contractId: contractId));
              } else {
                // User is on contract screen but viewing different contract, call API
                print(
                    '🔔 User on contract screen but viewing different contract, calling API');
                print(
                    '🔍 DEBUG: Calling GetContractDetail with contractId = $contractId');
              }
            } else {
              // User is not on contract screen, call API
              print('🔔 User not on contract screen, calling API');
              print(
                  '🔍 DEBUG: Calling GetContractDetail with contractId = $contractId');
            
            }
          } else {
            print('❌ DEBUG: Contract ID is null from notification data');
          }
        }
       
      }
      MyNotification.showNotification(
          message, flutterLocalNotificationsPlugin, true);

      // if (type == "video_call" ||
      //     type == "audio_call" ||
      //     type == "video" ||
      //     type == "audio") {
      //   print('user is calling');
      //   if (Get.currentRoute != "/DashboardScreen") {
      //     MyNotification.showNotification(
      //         message, flutterLocalNotificationsPlugin, true);
      //   }
      // } else {
      //   if (Get.currentRoute != RouteHelper.getChatConversationRoute()) {
      //     MyNotification.showNotification(
      //         message, flutterLocalNotificationsPlugin, true);
      //   }

      //   if (type == "chat") {
      //     // String id = message.data['chat_id'] ?? message.data['chatId'];
      //     Get.find<ChatController>().getTicket(false);
      //     // Get.find<ChatController>().getChatList(id, 0, true);
      //     // Get.to(() => ChatConversation(
      //     //       productId: id,
      //     //       receivedId: '',
      //     //     ));
      //   }
      //   if (type == 'order') {
      //     String id = message.data['notification_id'];
      //     Get.find<MarketOrderController>().getOrders(true, 1);
      //     Get.find<MarketOrderController>().getOrderDetail(id);
      //   }

      //   await audioPlayer.play(AssetSource('audio/success.mp3'));
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessage openapp: ${message.data}");
      print("onMessage open app: ${message.notification}");
      //Get.to(NotificationScreen());

      // String id = message.data['chatId'] ?? message.data['chat_id'];
      String type = message.data['notification_type'];
      String id = message.data['chatId'] ?? '';
      if (type == 'chat-product') {
        // add api to get chat detail
        print('this is the product open app chat id = $id');
        Get.to(() => ChatConversation(
              chatId: id,
              // isSeller: true,
              isFirstMessage: false,
              chatItem: null,
            ));
      } else if (type == 'chat-tender') {
        print('this is the tender open app chat id = $id');
        Get.to(() => ChatConversation(
              chatId: id,
              // isSeller: true,
              isFirstMessage: false,
              chatItem: null,
            ));
      } else {
        String status = message.data['notification_type'];
        String contractId = message.data['contract_id'] ??
            message.data['product_id'] ??
            message.data['tender_id'];
        String notificationId = message.data['notification_id'];
        NotificationService.handleNotificationClick(
            status, contractId, notificationId, context);
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String? _title;
      String? _body;
      String? _orderID;
      String? _image;
      String? _type;
      String? _reciverId;
      String? _contractId;
      String? _notificationId;
      if (data) {
        _title = message.data['title'] ?? '';
        _body = message.data['body'] ?? '';
        _orderID = message.data['chatId'];
        _reciverId =
            message.data['senderId']; // replace there receiverId with senderId
        // message.data['notification_id'];
        _type = message.data['notification_type'];
        _contractId = message.data['contract_id'] ??
            message.data['product_id'] ??
            message.data['tender_id'];
        _notificationId = message.data['notification_id'];
        // message.data['contract_id'];
        _image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image'].startsWith('http')
                    ? message.data['image']
                    : '${message.data['image']}'
                : null;
        if (_type == 'order' || _type == 'shorts_live_story') {
          _orderID = message.data['notification_id'];
          if (_type == 'shorts_live_story') {
            _reciverId = message.data['shorts_type'];
          }
        }
      } else {
        _title = message.notification?.title ?? '';
        _body = message.notification?.body ?? '';
        _orderID = message.data['notification_id'] ??
            message.notification?.titleLocKey;
        _contractId = message.data['contract_id'] ??
            message.data['product_id'] ??
            message.data['tender_id'];
        _notificationId = message.data['notification_id'];
        // message.data['contract_id'];
        if (GetPlatform.isAndroid) {
          _image = (message.notification?.android?.imageUrl != null)
              ? message.notification?.android?.imageUrl
              : null;
        } else if (GetPlatform.isIOS) {
          _image = (message.notification?.apple?.imageUrl != null)
              ? message.notification?.apple?.imageUrl
              : null;
        }
      }

      // NotificationAppLaunchDetails? fl = await fln.getNotificationAppLaunchDetails();

      if (_image != null && _image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              _title,
              _body,
              _orderID,
              _image,
              _type,
              _reciverId,
              _contractId,
              _notificationId,
              fln);
        } catch (e) {
          await showBigTextNotification(
              _title,
              _body,
              _orderID == null ? "0" : _orderID,
              _type == null ? "normal" : _type,
              _reciverId ?? "",
              _contractId ?? '',
              _notificationId ?? '',
              fln);
        }
      }
      // else if (_type == "video_call" || _type == "audio_call" || _type == "video" || _type == "audio") {
      //   await showIncomingCall(
      //     callerName: _title ?? '',
      //     callId: _orderID ?? '',
      //     isVideo: _type == 'video_call' || _type == 'video',
      //     // title: _title ?? '',
      //     // body: _body ?? '',
      //     // callType: 'audio / video call',
      //     // callerId: _reciverId ?? '',
      //     // fln: fln,
      //   );
      // }
      else {
        await showBigTextNotification(
            _title,
            _body,
            _orderID == null ? "0" : _orderID,
            _type == null ? "normal" : _type,
            _reciverId ?? "",
            _contractId ?? '',
            _notificationId ?? '',
            fln);
      }
    }
  }

  static Future<void> showBigTextNotification(
      String? title,
      String? body,
      String orderID,
      String type,
      String receiverId,
      String contractId,
      String notificationId,
      FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body!,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "default_channel",
      AppConstants.appName,
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      fullScreenIntent:
          true, // Important for showing notifications in locked screen
      playSound: true,
      icon: '@drawable/notification_icon',
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: orderID +
            "," +
            type +
            "," +
            receiverId +
            "," +
            contractId +
            "," +
            notificationId);
  }

  static Future<void> showTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'];
    String _body = message['body'];
    String _orderID = message['notification_id'];
    String _type = message['notification_type'];
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_channel',
      AppConstants.appName,
      icon: '@drawable/notification_icon',
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics,
        payload: _orderID + "," + _type);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String? title,
      String? body,
      String? orderID,
      String image,
      String? type,
      String? receiverId,
      String? contractId,
      String? notificationId,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "default_channel",
      AppConstants.appName,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.high,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.high,
      icon: '@drawable/notification_icon',
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: orderID! +
            "," +
            type! +
            "," +
            receiverId! +
            "," +
            contractId! +
            "," +
            notificationId!);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

@pragma('vm:entry-point')
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the plugin (required in background)
  const androidInit =
      AndroidInitializationSettings('@drawable/notification_icon');
  const iOSInit = DarwinInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true);
  const initSettings = InitializationSettings(
    android: androidInit,
    iOS: iOSInit,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  final type = message.data['notification_type'] ?? '';
  print('🔔 Received background FCM of type: $type');
}
