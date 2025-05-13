import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/data/model/response/notification/notifications_model.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData notification;
  final int index;

  const NotificationItem(
      {super.key, required this.notification, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<NotificationBloc>()
            .add(ReadNotification(notification.id.toString()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notification.readAt == '' ? Colors.white12 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Color.fromRGBO(16, 24, 40, 0.1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index % 2 == 0
                      ? ColorResources.blue
                      : ColorResources.green,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  index % 2 == 0 ? Images.svgWallet : Images.svgShoppingBag,
                  height: 16,
                  width: 16,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title ?? '',
                            // 'Вам был отправлен документ от компании ст',
                            style: h16.copyWith(color: ColorResources.darkGray),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          formatDateInRu(notification.createdAt.toString()),
                          // '12 сен. 2024',
                          style: body12.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      notification.description ?? '',
                      // 'Садовая мебель Loft добавил вашу закупку',
                      style: body14.copyWith(color: ColorResources.gray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
