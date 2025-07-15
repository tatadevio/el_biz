import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<void> sendNotificationToToken(
    {String? title,
    String? message,
    String? fcmToken,
    String? chatId,
    String? senderId,
    String type = 'normal',
    String? receiverId}) async {
  print("sending notification to ${fcmToken}");
  final jsonString = await rootBundle.loadString('assets/b2b-adminsdk.json');
  final serviceAccountKey = jsonDecode(jsonString);

  final accountCredentials =
      ServiceAccountCredentials.fromJson(serviceAccountKey);

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final authClient = await clientViaServiceAccount(accountCredentials, scopes);

  final url =
      'https://fcm.googleapis.com/v1/projects/b2bapp-8c342/messages:send';

  final response = await authClient.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'message': {
        'token': fcmToken,
        'notification': {
          'title': title,
          'body': message,
        },
        'data': {
          'title': title,
          'body': message,
          "chatId": chatId,
          "senderId": senderId,
          "message": message,
          "notification_type": type,
          "receiverId": receiverId
        }
      },
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }

  authClient.close();
}
