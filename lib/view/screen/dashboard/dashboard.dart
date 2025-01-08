import 'package:el_biz/bloc/config/config_bloc.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/tender/tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../menu/menu_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> _screens = [];
  int _pageIndex = 0;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  // FirebaseDynamicLinkService firebaseDynamicLinkService = FirebaseDynamicLinkService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _screens = [
      const HomeScreen(),
      const ProductScreen(),
      const TenderScreen(),
      const ChatScreen(),
      const MenuScreen(),
    ];
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
          unselectedItemColor: Color(0xff646F7F),
          backgroundColor: ColorResources.white,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor),
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

        // BottomAppBar(
        //   color: ColorResources.white,
        //   clipBehavior: Clip.antiAlias,
        //   shape: const CircularNotchedRectangle(),
        //   child: SizedBox(
        //     height: GetPlatform.isWeb ? Get.height * 0.073 : Get.height * 0.068,
        //     child: Padding(
        //       padding: const EdgeInsets.only(
        //           left: 8.0, right: 8.0, top: 8.0, bottom: 0),
        //       child: Row(children: [
        //         BottomNavItem(
        //           iconData: Images.svgHome,
        //           isSelected: configState.selectedIndex == 0,
        //           // configState.selectedIndex == 0,
        //           onTap: () => _setPage(0),
        //           title: "home".tr,
        //         ),
        //         BottomNavItem(
        //           iconData: Images.svgCategory,
        //           isSelected: configState.selectedIndex == 1,
        //           onTap: () => _setPage(1),
        //           title: "products".tr,
        //         ),
        //         BottomNavItem(
        //           iconData: Images.svgTenders,
        //           isSelected: configState.selectedIndex == 2,
        //           onTap: () => _setPage(2),
        //           title: "tenders".tr,
        //         ),
        //         BottomNavItem(
        //           iconData: Images.svgChat,
        //           isSelected: configState.selectedIndex == 3,
        //           onTap: () => _setPage(3),
        //           title: "chats".tr,
        //         ),
        //         BottomNavItem(
        //           iconData: Images.svgProfile,
        //           isSelected: configState.selectedIndex == 4,
        //           onTap: () => _setPage(4),
        //           title: "profile".tr,
        //         ),
        //       ]),
        //     ),
        //   ),
        // );
      }),
      body:
          BlocBuilder<ConfigBloc, ConfigState>(builder: (context, configState) {
        return PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[configState.selectedIndex];
          },
        );
      }),
    );
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> list = [
      _barItem(Images.svgHome, 'home', 0),
      _barItem(Images.svgCategory, 'products', 1),
      _barItem(Images.svgTenders, 'tenders', 2),
      _barItem(Images.svgChat, 'chats', 3),
      _barItem(Images.svgProfile, 'profile', 4),
    ];

    return list;
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: index == _pageIndex ? ColorResources.primary : Color(0xff646F7F),
        height: 25,
        width: 25,
      ),
      label: label.tr,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
    // Get.find<ConfigController>().changeIndex(_pageIndex);
    context.read<ConfigBloc>().add(ChangeIndex(_pageIndex));
  }
}
