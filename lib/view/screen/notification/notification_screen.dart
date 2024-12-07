import 'package:el_biz/controller/notification_controller.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GetBuilder<NotificationController>(builder: (notificationController) {
          if (notificationController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (notificationController.notificationList.isNotEmpty) {
            return Center(
              child: Text(
                'Нет уведомлений',
                style: body16.copyWith(color: ColorResources.gray),
              ),
            );
          }
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return NotificationItem(
                index: index,
              );
            },
          );
        }),
      ),
    );
  }
}
