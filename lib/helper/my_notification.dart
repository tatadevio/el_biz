import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../utils/appConstant.dart';

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
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse details) async {
        String? payload = details.payload;
        try {
          if (payload != null && payload.isNotEmpty) {
            print('payload is : $payload');
            List<String> result = payload.split(',');
            String id = result[0];
            String type = result[1];
            String receiverid = result[2];
            print("payload is $id  and $type");
            if (type == "chat") {
              // if (Get.find<AuthController>().isLoggedIn()) {
              // Get.find<ChatController>().getTicket(true);
              // Get.find<ChatController>().getChatList(id, 0, true);
              // print('going to check the routes');
              // if (Get.currentRoute == "/ChatConversation") {
              //   Get.off(
              //       () => ChatConversation(
              //             productId: id,
              //             receivedId: receiverid,
              //           ),
              //       preventDuplicates: false);
              // } else {
              //   Get.to(
              //       () => ChatConversation(
              //             productId: id,
              //             receivedId: receiverid,
              //           ),
              //       preventDuplicates: false);
              // }
              // }
            } else if (type == "normal") {}

            /*Get.find<BooksDetailController>().bookDetail(payload.toString());
            Get.to(BooksDetails());*/
            //Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
          } else {}
        } catch (e) {
          debugPrint("error is $e");
        }
        return;
      },
      //     onSelectNotification: (String? payload) async {
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      //showShortToast("Background message ${message?.data}");
      print("initial message  i am coming = ${message?.data}");
      if (message?.data != null) {
        print(message?.data);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: ${message.data}");
      print("onMessage: ${message.notification}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessage openapp: ${message.data}");
      print("onMessage open app: ${message.notification}");

      // String id = message.data['chatId'] ?? message.data['chat_id'];
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
      if (data) {
        _title = message.data['title'];
        _body = message.data['body'];
        _orderID = message.data['chatId'];
        _reciverId =
            message.data['senderId']; // replace there receiverId with senderId
        // message.data['notification_id'];
        _type = message.data['notification_type'];
        _image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image'].startsWith('http')
                    ? message.data['image']
                    : '${message.data['image']}'
                : null;
      } else {
        _title = message.notification?.title;
        _body = message.notification?.body;
        _orderID = message.notification?.titleLocKey;
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
              _title, _body, _orderID, _image, _type, _reciverId, fln);
        } catch (e) {
          await showBigTextNotification(
              _title,
              _body,
              _orderID == null ? "0" : _orderID,
              _type == null ? "normal" : _type,
              _reciverId ?? "",
              fln);
        }
      } else {
        await showBigTextNotification(
            _title,
            _body,
            _orderID == null ? "0" : _orderID,
            _type == null ? "normal" : _type,
            _reciverId ?? "",
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
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      fullScreenIntent:
          true, // Important for showing notifications in locked screen
      playSound: true,
      icon: '@drawable/notification_icon',
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: orderID + "," + type + "," + receiverId);
  }

  static Future<void> showTextNotification(
      Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'];
    String _body = message['body'];
    String _orderID = message['notification_id'];
    String _type = message['notification_type'];
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      icon: '@drawable/notification_icon',
      'default_channel',
      'your channel name',
      sound: RawResourceAndroidNotificationSound('notification'),
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
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      icon: '@drawable/notification_icon',
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: orderID! + "," + type! + "," + receiverId!);
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

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  //MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
  // MyNotification.showNotification(message, flutterLocalNotificationsPlugin, true);
}
