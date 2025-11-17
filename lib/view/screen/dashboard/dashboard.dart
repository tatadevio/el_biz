import 'package:el_biz/bloc/config/config_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/tender/tender_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../helper/my_notification.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../auction/auctions/auctions_screen.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> _screens = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // FirebaseDynamicLinkService firebaseDynamicLinkService = FirebaseDynamicLinkService();

  // final updater = ShorebirdUpdater();

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const TenderScreen(),
      const AuctionsScreen(),
      const ChatScreen(),
      const ProductScreen(),
    ];
    initNotify();
    updateFcmToken();
  }

  updateFcmToken() async {
    if (context.read<AuthBloc>().state.isLoggedIn) {
      context
          .read<UserBloc>()
          .add(GetUserInfo(context: context, isUpdateToken: true));
      //  context.read<UserBloc>().add(GetSelectedAccount(context: context));
      // context.read<AuthBloc>().add(UpdateFirebaseToken(
      //       context.read<UserBloc>().state.user?.id ?? "",
      //     ));
    }
  }

  initNotify() async {
    await MyNotification.initialize(flutterLocalNotificationsPlugin, context);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  bool singleVendor = false;
  bool isCanPop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      bottomNavigationBar:
          BlocBuilder<ConfigBloc, ConfigState>(builder: (context, configState) {
        return BottomNavigationBar(
          selectedItemColor: ColorResources.primary,
          unselectedItemColor: Color.fromRGBO(208, 213, 221, 1),
          // Color(0xff646F7F),
          backgroundColor: ColorResources.white,
          showUnselectedLabels: true,
          currentIndex: configState.selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor, configState),
          onTap: (int index) {
            _setPage(index);
            if (index == 0) {
              // setState(() {
              isCanPop = true;
              // });
            } else {
              isCanPop = false;
            }
          },
        );
      }),
      body:
          BlocBuilder<ConfigBloc, ConfigState>(builder: (context, configState) {
        return PageView.builder(
          controller: configState.pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[configState.selectedIndex];
          },
        );
      }),
    );
  }

  List<BottomNavigationBarItem> _getBottomWidget(
      bool isSingleVendor, ConfigState state) {
    List<BottomNavigationBarItem> list = [
      _barItem(Images.svgHome, 'home', 0, state),
      _barItem(Images.svgTenders, 'tenders', 1, state),
      _barItem(Images.svgChart, 'auctions', 2, state),
      _barItem(Images.svgChat, 'chats', 3, state),
      _barItem(Images.svgCategory, 'products', 4, state),
    ];

    return list;
  }

  BottomNavigationBarItem _barItem(
      String icon, String label, int index, ConfigState state) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: index == state.selectedIndex
            ? ColorResources.primary
            : Color.fromRGBO(208, 213, 221, 1),
        //  Color(0xff646F7F),
        height: 25,
        width: 25,
      ),
      label: label.tr,
    );
  }

  void _setPage(int pageIndex) {
    // setState(() {
    //   _pageController.jumpToPage(pageIndex);
    //   // _pageIndex = pageIndex;
    // });
    // Get.find<ConfigController>().changeIndex(_pageIndex);
    context.read<ConfigBloc>().add(ChangeIndex(pageIndex));
  }
}
