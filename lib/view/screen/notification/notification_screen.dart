import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationBloc>().add(GetNotification(1));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, notificationState) {
            if (notificationState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (notificationState.notificationsList.isEmpty) {
              return Center(
                child: Text(
                  'no_notifications'.tr,
                  style: body16.copyWith(color: ColorResources.gray),
                ),
              );
            }
            return ListView.builder(
              itemCount: notificationState.notificationsList.length,
              itemBuilder: (context, index) {
                return NotificationItemWidget(
                  notification: notificationState.notificationsList[index],
                  index: index,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
