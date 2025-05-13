import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/account/account_screen.dart';
import 'package:el_biz/view/screen/auth/login.dart';
import 'package:el_biz/view/screen/favorite/favorite_screen.dart';
import 'package:el_biz/view/screen/language/language_screen.dart';
import 'package:el_biz/view/screen/menu/profile_information_screen.dart';
import 'package:el_biz/view/screen/menu/widgets/add_company_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/tin_number/tin_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_dialog.dart';
import '../company/widgets/show_company_detail_box.dart';
import '../company/widgets/show_llc_issue_box.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorResources.background,
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(20.0),
        //         bottomRight: Radius.circular(20.0))),
        // bottomOpacity: 10,
        // toolbarOpacity: 1,
        // elevation: 0.5,
        centerTitle: false,
        title: Text(
          "profile".tr,
          style: const TextStyle(
              color: Color(0xff212020),
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: BlocListener<TinBloc, TinState>(
        listener: (context, state) {
          if (state is TinSuccess) {
            Get.dialog(
              CustomDialog(
                widget: AlertDialog(
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(5),
                  content: Padding(
                    padding: EdgeInsets.all(0),
                    child: ShowCompanyDetailBox(tinNumber: state.tinNumber),
                  ),
                ),
              ),
            );
          }
          if (state is TinError) {
            Get.dialog(
              const CustomDialog(
                widget: AlertDialog(
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(5),
                  content: Padding(
                    padding: EdgeInsets.all(0),
                    child: ShowLlcIssueBox(),
                  ),
                ),
              ),
            );
          }
          // if (state is TinLoading) {
          //   Get.dialog(
          //     const CustomDialog(
          //       widget: CircularProgressIndicator(),
          //     ),
          //   );
          // }
        },
        child: BlocBuilder<TinBloc, TinState>(
          builder: (context, tinState) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              userState.selectedAccountModel?.isUser == true
                                  ? userState.selectedAccountModel?.userName ??
                                      ''
                                  : userState
                                          .selectedAccountModel?.companyName ??
                                      '',
                              // 'Имя Фамилия',
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              userState.selectedAccountModel?.isUser == true
                                  ? userState.selectedAccountModel?.userPhone ??
                                      ''
                                  : userState
                                          .selectedAccountModel?.companyPhone ??
                                      '',
                              // '+996 999 999 999',
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              userState.selectedAccountModel?.isUser == true
                                  ? userState.selectedAccountModel?.userEmail ??
                                      ''
                                  : userState
                                          .selectedAccountModel?.companyEmail ??
                                      '',
                              // 'email@gmail.com',
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          cusotmInfoList(
                            Images.svgUser,
                            'personal_information'.tr,
                            isSelected: true,
                            onTap: () {
                              Get.to(() => const ProfileInformationScreen());
                            },
                          ),
                          cusotmInfoList(
                            Images.svgCompanies,
                            'my_companies'.tr,
                            isSelected: false,
                            onTap: () {
                              Get.bottomSheet(const AddCompanyBottomSheet(),
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true);
                            },
                          ),
                          cusotmInfoList(
                            Images.svgCreditCard,
                            'current_accounts'.tr,
                            isSelected: false,
                            onTap: () {
                              Get.to(() => const AccountScreen());
                            },
                          ),
                          cusotmInfoList(
                            Images.svgHeartBorder,
                            'favorites'.tr,
                            isSelected: false,
                            onTap: () {
                              context
                                  .read<FavoriteBloc>()
                                  .add(GetFavoriteProducts(1));
                              context
                                  .read<FavoriteBloc>()
                                  .add(GetFavoriteTenders(1));

                              Get.to(() => const FavoriteScreen());
                            },
                          ),
                          cusotmInfoList(
                            Images.language,
                            'language'.tr,
                            isSelected: false,
                            onTap: () {
                              Get.bottomSheet(
                                  isScrollControlled: true,
                                  const ChooseLanguageScreen(
                                    fromMenu: false,
                                  ));
                            },
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Row(
                                children: [
                                  Text(
                                    'about_application'.tr,
                                    style: body16.copyWith(
                                        color: ColorResources.gray),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          cusotmInfoList(
                            Images.svgLogout,
                            'logout_of_profile'.tr,
                            isSelected: false,
                            onTap: () {
                              Get.dialog(CustomDialog(
                                  widget: AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: const BoxDecoration(
                                          color: ColorResources.lightBlue,
                                          shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          Images.svgHelpCircle),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${"logout_of_profile".tr}?',
                                      style: h16.copyWith(
                                        color:
                                            const Color.fromRGBO(16, 24, 40, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: Get.width,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            color: ColorResources.lgColor,
                                            child: Text(
                                              "cancel".tr,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorResources.gray),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.clear();

                                              Get.back();
                                              Get.offAll(
                                                  () => const LoginScreen());
                                            },
                                            color: ColorResources.primary,
                                            child: Text(
                                              "logout".tr,
                                              style: const TextStyle(
                                                  letterSpacing: 0.5,
                                                  fontSize: 16,
                                                  color: Colors.white),
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
                            'delete_profile'.tr,
                            textColor: ColorResources.red,
                            isSelected: false,
                            onTap: () {
                              Get.dialog(CustomDialog(
                                  widget: AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              253, 162, 155, 0.5),
                                          shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        Images.svgHelpCircle,
                                        color: ColorResources.red,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${'delete_profile'.tr}?",
                                      style: h16.copyWith(
                                        color:
                                            const Color.fromRGBO(16, 24, 40, 1),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "once_your_profile_is_deleted_all_your_company_data_and_history_will_be_deleted"
                                          .tr,
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            color: ColorResources.lgColor,
                                            child: Text(
                                              "cancel".tr,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorResources.gray),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            onPressed: () async {
                                              Get.back();
                                              Get.offAll(
                                                  () => const LoginScreen());
                                            },
                                            color: ColorResources.red,
                                            child: Text(
                                              "delete".tr,
                                              style: const TextStyle(
                                                  letterSpacing: 0.5,
                                                  fontSize: 16,
                                                  color: Colors.white),
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
                    if (tinState is TinLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget cusotmInfoList(String icon, String title,
      {bool isSelected = false,
      Function()? onTap,
      Color? textColor = Colors.grey}) {
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
              icon.contains('.svg')
                  ? SvgPicture.asset(icon)
                  : Image.asset(
                      icon,
                      color: ColorResources.gray,
                    ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: body16.copyWith(
                    color: isSelected ? Colors.white : textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
