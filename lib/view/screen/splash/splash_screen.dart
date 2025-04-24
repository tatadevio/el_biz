import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/config/config_bloc.dart';
import 'package:el_biz/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/route_helper.dart';
import '../../../utils/Images.dart';
import '../../../utils/appConstant.dart';
import '../dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    call();
    Future.delayed(Duration.zero, () {
      // context.read<CitiesBloc>().add(const GetCitites(50, true));
      // context.read<ConfigBloc>().add(GetPrivacy());
      // context.read<ConfigBloc>().add(GetTerms());
      // context.read<ConfigBloc>().add(GetAbout());
      // context.read<ConfigBloc>().add(GetConfig());
    });
  }

  call() async {
    context.read<AuthBloc>().add(CheckLoginStatus());
    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // bool isNew = preferences.getBool("new") ?? true;
    // String token = preferences.getString(AppConstants.token) ?? "";
    // print("this is token: $token");
    Future.delayed(const Duration(seconds: 2), () {
      // if (isNew) {
      //   Get.offAll(
      //     () => const ChangeLanguage(),
      //   );
      //   return;
      // }

      if (context.read<AuthBloc>().state.isLoggedIn) {
        HomeScreen().loadData(context);
        Get.offAll(() => const DashboardScreen());
      } else {
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }
      context.read<AuthBloc>().add(UpdateUserFirebaseData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Images.splashBg), fit: BoxFit.cover)),
        child: Center(
          child: SvgPicture.asset(
            Images.svgsplashLogo,
            width: Get.width * 0.64,
          ),
        ),
      ),
    );
  }
}
