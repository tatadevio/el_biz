import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/account/account_screen.dart';
import 'package:el_biz/view/screen/favorite/favorite_screen.dart';
import 'package:el_biz/view/screen/menu/profile_information_screen.dart';
import 'package:el_biz/view/screen/menu/widgets/add_company_bottom_sheet.dart';
import 'package:el_biz/view/screen/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_dialog.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isLogin = Get.find<AuthController>().isLoggedIn();
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
        //shadowColor: Color(0xff101828).withOpacity(0.6),

        bottomOpacity: 10,
        toolbarOpacity: 1,
        elevation: 0.5,
        centerTitle: false,
        title: Text(
          "profile".tr,
          style: const TextStyle(color: Color(0xff212020), fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: const [
          // if (isLogin)
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Имя Фамилия',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '+996 999 999 999',
                style: body14.copyWith(color: ColorResources.gray),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'email@gmail.com',
                style: body14.copyWith(color: ColorResources.gray),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            cusotmInfoList(
              Images.svgUser,
              'Личные данные',
              isSelected: true,
              onTap: () {
                Get.to(() => ProfileInformationScreen());
              },
            ),
            cusotmInfoList(
              Images.svgCompanies,
              'Мои компании',
              isSelected: false,
              onTap: () {
                Get.bottomSheet(AddCompanyBottomSheet(), backgroundColor: Colors.white, isScrollControlled: true);
              },
            ),
            cusotmInfoList(
              Images.svgCreditCard,
              'Расчётные счета',
              // 'Счета на оплату',
              isSelected: false,
              onTap: () {
                // Get.to(() => ProfileInformationScreen());
                Get.to(() => AccountScreen());
              },
            ),
            cusotmInfoList(
              Images.svgHeartBorder,
              'Избранное',
              isSelected: false,
              onTap: () {
                Get.to(() => FavoriteScreen());
              },
            ),
            cusotmInfoList(
              Images.svgFileText,
              'Помощь',
              isSelected: false,
              onTap: () {
                Get.to(() => SupportScreen());
              },
            ),
            cusotmInfoList(
              Images.svgLogout,
              'Выйти из профиля',
              isSelected: false,
              onTap: () {
                Get.dialog(CustomDialog(
                    widget: AlertDialog(
                  title: Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(color: ColorResources.lightBlue, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(Images.svgHelpCircle),
                      ),
                    ],
                  ),
                  // Text("are_you_sure".tr),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Выйти из профиля?".tr,
                        style: h16.copyWith(
                          color: Color.fromRGBO(16, 24, 40, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              color: ColorResources.lgColor,
                              child: Text(
                                "no".tr,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorResources.gray),
                              ),
                              //  Colors.grey[300],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MaterialButton(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () async {
                                Get.back();
                              },
                              color: ColorResources.primary,
                              child: Text(
                                "yes".tr,
                                style: TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )));
              },
            ),
            cusotmInfoList(
              Images.svgTrash,
              'Удалить профиль',
              isSelected: false,
              onTap: () {
                Get.dialog(CustomDialog(
                    widget: AlertDialog(
                  title: Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(color: Color.fromRGBO(253, 162, 155, 0.5), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgHelpCircle,
                          color: ColorResources.red,
                        ),
                      ),
                    ],
                  ),
                  // Text("are_you_sure".tr),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Удалить профиль?".tr,
                        style: h16.copyWith(
                          color: Color.fromRGBO(16, 24, 40, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "После удаления профиля все данные и истории вашей компании будут удалены.".tr,
                        style: body14.copyWith(
                          color: ColorResources.gray,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              color: ColorResources.lgColor,
                              child: Text(
                                "no".tr,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorResources.gray),
                              ),
                              //  Colors.grey[300],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MaterialButton(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () async {
                                Get.back();
                              },
                              color: ColorResources.red,
                              child: Text(
                                "yes".tr,
                                style: TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cusotmInfoList(String icon, String title, {bool isSelected = false, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? ColorResources.primary.withOpacity(0.5) : null,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: body16.copyWith(color: isSelected ? Colors.white : ColorResources.gray),
              ),
            ],
          ),
        ),
      ),
    );

    // ListTile(
    //   dense: true,
    //   onTap: () {
    //     ontap();
    //   },
    //   leading: SvgPicture.asset(
    //     icon,
    //     width: 18,
    //     height: 18,
    //   ),
    //   title: Text(
    //     title,
    //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff212020)),
    //   ),
    // );
  }
}
