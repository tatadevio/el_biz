import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/Images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    call();
  }

  call() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isNew = preferences.getBool("new") ?? true;

    Future.delayed(const Duration(seconds: 2), () {
      // if (isNew) {
      //   Get.offAll(
      //     () => const ChangeLanguage(),
      //   );
      //   return;
      // }

      if (Get.find<AuthController>().isLoggedIn()) {
        Get.offAllNamed(RouteHelper.getDashboardRoute());
      } else {
        // Get.to(() => AddProduct());
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }
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
