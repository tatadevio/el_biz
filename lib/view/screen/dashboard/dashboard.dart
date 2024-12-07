import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:el_biz/view/screen/tender/tender_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/config_controller.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../chat/chat_screen.dart';
import '../home/home_screen.dart';
import '../menu/menu_screen.dart';
import 'widget/bottom_nav_item.dart';

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
      ChatScreen(),
      const MenuScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      bottomNavigationBar: GetBuilder<ConfigController>(builder: (configController) {
        return BottomAppBar(
          color: ColorResources.white,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: GetPlatform.isWeb ? Get.height * 0.073 : Get.height * 0.068,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0),
              child: Row(children: [
                BottomNavItem(
                  iconData: Images.svgHome,
                  isSelected: configController.selectedIndex == 0,
                  onTap: () => _setPage(0),
                  title: "home".tr,
                ),
                BottomNavItem(
                  iconData: Images.svgCategory,
                  isSelected: configController.selectedIndex == 1,
                  onTap: () => _setPage(1),
                  title: "category".tr,
                ),
                BottomNavItem(
                  iconData: Images.svgTenders,
                  isSelected: configController.selectedIndex == 2,
                  onTap: () => _setPage(2),
                  title: "tenders".tr,
                ),
                BottomNavItem(
                  iconData: Images.svgChat,
                  isSelected: configController.selectedIndex == 3,
                  onTap: () => _setPage(3),
                  title: "chats".tr,
                ),
                BottomNavItem(
                  iconData: Images.svgProfile,
                  isSelected: configController.selectedIndex == 4,
                  onTap: () => _setPage(4),
                  title: "profile".tr,
                ),
              ]),
            ),
          ),
        );
      }),
      body: GetBuilder<ConfigController>(builder: (configController) {
        return PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[configController.selectedIndex];
          },
        );
      }),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
    Get.find<ConfigController>().changeIndex(_pageIndex);
  }
}
