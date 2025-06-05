import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/view/screen/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/notification/notification_bloc.dart';
import '../../utils/Images.dart';
import '../../utils/color_resources.dart';

class AppbarNotificationButton extends StatelessWidget {
  const AppbarNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      if (authState.isLoggedIn == false) {
        return SizedBox.shrink();
      }
      return InkWell(
        onTap: () {
          context.read<NotificationBloc>().add(GetNotification(1));
          Get.to(() => NotificationScreen());
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorResources.primary,
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Color.fromRGBO(16, 24, 40, 0.05),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(Images.svgBell),
        ),
      );
    });
  }
}
