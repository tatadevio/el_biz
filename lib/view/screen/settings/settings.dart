import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/config_controller.dart';
import '../../../controller/post_ad_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/product_detail_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../utils/Images.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_image.dart';
import '../../base/custom_name_image.dart';
import 'privacy_page.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0.2,
        title: Text(
          "setting".tr,
          style: const TextStyle(color: ColorResources.black),
        ),
      ),
      body: GetBuilder<ConfigController>(builder: (configController) {
        return GetBuilder<UserController>(builder: (userController) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20.0), boxShadow: const [
                      ColorResources.shadow1,
                      ColorResources.shadow2,
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                      child: Row(
                        children: [
                          userController.userInfoModel!.data.image.isNotEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorResources.iconColor,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(160.0),
                                    child: CustomImage(
                                      image: userController.userInfoModel!.data.image,
                                      height: Get.height * 0.08,
                                      width: Get.height * 0.08,
                                      fit: BoxFit.cover,
                                      radius: 0.0,
                                    ),
                                  ),
                                )
                              : CustomNameImageWidget(
                                  name: userController.userInfoModel!.data.name,
                                  height: Get.height * 0.08,
                                  width: Get.height * 0.08,
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: Get.width * .67,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userController.userInfoModel!.data.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.textBlack,
                                  ),
                                ),
                                Text(
                                  userController.userInfoModel!.data.email,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff475467)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Container(
                  //   decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12.0), boxShadow: const [
                  //     ColorResources.shadow1,
                  //     ColorResources.shadow2,
                  //   ]),
                  //   child: Column(
                  //     children: [
                  //       customList(Images.language, "language".tr, () {
                  //         Get.bottomSheet(
                  //             isScrollControlled: false,
                  //             ChooseLanguageScreen(
                  //               fromMenu: false,
                  //             ));
                  //       }),
                  //       // const Divider(
                  //       //   color: Color(0xffF5F5F5),
                  //       //   thickness: 2,
                  //       // ),
                  //       // customList(Images.svgWallet, "link_a_card".tr, () {}),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20.0), boxShadow: const [
                      ColorResources.shadow1,
                      ColorResources.shadow2,
                    ]),
                    child: Column(
                      children: [
                        // customList(Images.svgHelpCircleNew, "contactsupport".tr, () {
                        //   Get.to(() => const ContactSupportScreen());
                        // }),
                        // const Divider(
                        //   color: Color(0xffF5F5F5),
                        //   thickness: 2,
                        // ),
                        // customList(Images.checkCode, "about_the_application".tr, () {
                        //   Get.find<ConfigController>().getAbout();
                        //   Get.to(() => const Privacy());
                        // }),
                        // const Divider(
                        //   color: Color(0xffF5F5F5),
                        //   thickness: 2,
                        // ),
                        // customList(Images.svgLockNew, "privacy_policy".tr, () {
                        //   Get.find<ConfigController>().getPrivacy();
                        //   Get.to(() => const Privacy());
                        // }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).cardColor,
                  //       borderRadius: BorderRadius.circular(12.0),
                  //       boxShadow: const [
                  //         ColorResources.shadow1,
                  //         ColorResources.shadow2,
                  //       ]),
                  //   child: Column(
                  //     children: [
                  //       // customList1(
                  //       //     "receive_SMS".tr, "Важные уведомления...", () {}),
                  //       // const Divider(
                  //       //   color: Color(0xffF5F5F5),
                  //       //   thickness: 2,
                  //       // ),
                  //       // customList1(
                  //       //     "ads_in_subscriptions".tr, "Новые товары", () {}),
                  //       // const Divider(
                  //       //   color: Color(0xffF5F5F5),
                  //       //   thickness: 2,
                  //       // ),
                  //       customList1(
                  //           "my_advertisements".tr, "При изменении статуса...",
                  //           () {
                  //         Get.to(() => SellerScreen(
                  //
                  //               isSeller: true,
                  //             ));
                  //       }),
                  //     ],
                  //   ),
                  // ),

                  // Container(
                  //   decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12.0), boxShadow: const [
                  //     ColorResources.shadow1,
                  //     ColorResources.shadow2,
                  //   ]),
                  //   child: customList(Images.svgLogout, "log_out".tr, () {
                  //     Get.dialog(CustomDialog(
                  //         widget: AlertDialog(
                  //       title: Text("are_you_sure".tr),
                  //       content: Text(
                  //         "do_you_exit".tr,
                  //         style: const TextStyle(letterSpacing: 0.5),
                  //       ),
                  //       actions: [
                  //         MaterialButton(
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  //           onPressed: () {
                  //             Get.back();
                  //           },
                  //           color: Colors.grey[300],
                  //           child: Text(
                  //             "no".tr,
                  //             style: const TextStyle(letterSpacing: 0.5, fontSize: 16),
                  //           ),
                  //         ),
                  //         MaterialButton(
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  //           onPressed: () async {
                  //             if (Get.find<AuthController>().isLoggedIn()) {
                  //               Get.delete<UserController>();
                  //               Get.delete<ProductDetailController>();
                  //               Get.delete<ProductController>();
                  //               Get.delete<PostAdController>();
                  //               SharedPreferences prefers = await SharedPreferences.getInstance();

                  //               prefers.clear();
                  //               print(prefers.containsKey(AppConstants.token));
                  //               await prefers.setBool("new", false);
                  //             }
                  //             SharedPreferences prefers = await SharedPreferences.getInstance();
                  //             prefers.clear();
                  //             Get.offAllNamed(RouteHelper.getLoginRoute());
                  //             await prefers.setBool("new", false);
                  //           },
                  //           color: Colors.red,
                  //           child: Text(
                  //             "yes".tr,
                  //             style: const TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
                  //           ),
                  //         ),
                  //       ],
                  //     )));
                  //   }),
                  // ),

                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12.0), boxShadow: const [
                  //     ColorResources.shadow1,
                  //     ColorResources.shadow2,
                  //   ]),
                  //   child: ListTile(
                  //     dense: true,
                  //     onTap: () {
                  //       Get.dialog(CustomDialog(
                  //           widget: AlertDialog(
                  //         title: Text("are_you_sure".tr),
                  //         content: Text(
                  //           "do_you_delete_account".tr,
                  //           style: const TextStyle(letterSpacing: 0.5),
                  //         ),
                  //         actions: [
                  //           MaterialButton(
                  //             elevation: 0,
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  //             onPressed: () {
                  //               Get.back();
                  //             },
                  //             color: Colors.grey[300],
                  //             child: Text(
                  //               "no".tr,
                  //               style: const TextStyle(letterSpacing: 0.5, fontSize: 16),
                  //             ),
                  //           ),
                  //           MaterialButton(
                  //             elevation: 0,
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  //             onPressed: () async {
                  //               final SharedPreferences prefers = await SharedPreferences.getInstance();
                  //               Get.back();
                  //               Get.find<UserController>().deleteMyAccount().then((value) {
                  //                 if (value.isSuccess) {
                  //                   prefers.clear();
                  //                   Get.offAllNamed(RouteHelper.getLoginRoute());
                  //                 }
                  //               });
                  //             },
                  //             color: Colors.red,
                  //             child: Text(
                  //               "yes".tr,
                  //               style: const TextStyle(letterSpacing: 0.5, fontSize: 16, color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       )));
                  //     },
                  //     leading: SvgPicture.asset(
                  //       Images.deleteSvg,
                  //       width: 18,
                  //       height: 18,
                  //       color: ColorResources.primaryRed,
                  //     ),
                  //     title: Text(
                  //       "delete_account".tr,
                  //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorResources.primaryRed),
                  //     ),
                  //   ),
                  // ),

                  /*Column(
                        children: [
                          ListTile(
                            onTap: (){
                              showShortToast("Coming soon");
                           //   Get.find<ConfigController>().getPrivacy();
                             // Get.to(() => Privacy(title: configController.privacy!.data.title,
                             //   description: configController.privacy!.data.description,));
                            },
                            //leading: Image.asset(Images.privacy,width: 40,),
                            title: Text("Страна".tr,style: TextStyle(fontSize: 18,letterSpacing: 0.6),),
                            trailing: Text("Кыргызстан".tr,style: TextStyle(fontSize: 18,letterSpacing: 0.6,color: ColorResources.primary),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Divider(color: ColorResources.blueGrey2,),
                          ),
                        ],
                      ),*/
                  //  Column(
                  //    children: [
                  //      ListTile(
                  //        onTap: (){
                  //          Get.bottomSheet(
                  //              ChooseLanguageScreen(fromMenu: true,),isScrollControlled: true
                  //          );
                  //        },
                  //        //leading: Image.asset(Images.privacy,width: 40,),
                  //        title: Text("change_language".tr,style: const TextStyle(fontSize: 18,letterSpacing: 0.6),),
                  //        trailing: Text(Get.find<LocalizationController>().languages[Get.find<LocalizationController>().selectedIndex].languageName,style: const TextStyle(fontSize: 18,letterSpacing: 0.6,color: ColorResources.primary),),
                  //      ),
                  //      const Padding(
                  //        padding: EdgeInsets.only(left: 8.0),
                  //        child: Divider(color: ColorResources.blueGrey2,),
                  //      ),
                  //    ],
                  //  ),
                  //
                  //  Column(
                  //    children: [
                  //      ListTile(
                  //        onTap: (){
                  //          Get.find<ConfigController>().getPrivacy();
                  //          Get.to(() => const Privacy());
                  //        },
                  //        //leading: Image.asset(Images.privacy,width: 40,),
                  //        title: Text("privacy".tr,style: const TextStyle(fontSize: 18,letterSpacing: 0.6),),
                  //        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: ColorResources.hintColor,),
                  //      ),
                  //      const Padding(
                  //        padding: EdgeInsets.only(left: 8.0),
                  //        child: Divider(color: ColorResources.blueGrey2,),
                  //      ),
                  //    ],
                  //  ),
                  //
                  //
                  //
                  //  Column(
                  //    children: [
                  //      ListTile(
                  //        onTap: (){
                  //          Get.find<ConfigController>().getTerms();
                  //          Get.to(() => const Privacy());
                  //        },
                  //        //leading: Image.asset(Images.terms,width: 40,),
                  //        title: Text("terms".tr,style: const TextStyle(fontSize: 18,letterSpacing: 0.6),),
                  //        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: ColorResources.hintColor,),
                  //      ),
                  //      const Padding(
                  //        padding: EdgeInsets.only(left: 8.0),
                  //        child: Divider(color: ColorResources.secondaryGrey,),
                  //      ),
                  //    ],
                  //  ),
                  //
                  //  Column(
                  //    children: [
                  //      ListTile(
                  //        onTap: (){
                  //          Get.find<ConfigController>().getAbout();
                  //          Get.to(() => const Privacy());
                  //        },
                  //        //leading: SvgPicture.asset(Images.svgProfile,width: 40,),
                  //        title: Text("about".tr,style: const TextStyle(fontSize: 18,letterSpacing: 0.6),),
                  //        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: ColorResources.hintColor,),
                  //      ),
                  //      const Padding(
                  //        padding: EdgeInsets.only(left: 8.0),
                  //        child: Divider(color: ColorResources.blueGrey2,),
                  //      ),
                  //    ],
                  //  ),
                  //
                  //
                  // const SizedBox(height: 18,),
                  // InkWell(
                  //   onTap: (){
                  //     Get.dialog(CustomDialog(widget: AlertDialog(
                  //       title: Text("are_you_sure".tr),
                  //       content: Text("do_you_exit".tr,
                  //         style: const TextStyle(letterSpacing: 0.5),),
                  //       actions: [
                  //         MaterialButton(
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(6.0)
                  //           ),
                  //           onPressed: ()
                  //           {
                  //             Get.back();
                  //           },
                  //           child: Text("no".tr,style: const TextStyle(letterSpacing: 0.5,fontSize: 16),),
                  //           color: Colors.grey[300],
                  //         ),
                  //         MaterialButton(
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(6.0)
                  //           ),
                  //           onPressed: () async
                  //           {
                  //             if(Get.find<AuthController>().isLoggedIn()) {
                  //               Get.delete<UserController>();
                  //               Get.delete<ProductDetailController>();
                  //               Get.delete<ProductController>();
                  //               Get.delete<PostAdController>();
                  //               SharedPreferences prefers = await SharedPreferences.getInstance();
                  //
                  //               prefers.clear();
                  //               print(prefers.containsKey(AppConstants.token));
                  //             }
                  //             Get.offAllNamed(RouteHelper.getLoginRoute());
                  //             SharedPreferences prefers = await SharedPreferences.getInstance();
                  //             prefers.clear();
                  //             Get.offAllNamed(RouteHelper.getLoginRoute());
                  //           },
                  //           child: Text("yes".tr,
                  //             style: const TextStyle(letterSpacing: 0.5,fontSize: 16,color: Colors.white),),
                  //           color: Colors.red,
                  //         ),
                  //       ],
                  //     )));
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SvgPicture.asset(Images.svgLogout,height: 30,color: ColorResources.blueGrey3,),
                  //       const SizedBox(width: 15,),
                  //       Text("exit".tr,style: TextStyle(color: ColorResources.blueGrey3,fontSize: 18),)
                  //     ],
                  //   ),
                  // ),

                  /* if(Get.find<AuthController>().isLoggedIn())
                      Column(
                        children: [
                          ListTile(
                            onTap: (){
                              Get.dialog(CustomDialog(widget: AlertDialog(
                                title: Text("are_you_sure".tr),
                                content: Text("do_you_delete_account".tr,
                                  style: TextStyle(letterSpacing: 0.5),),
                                actions: [
                                  MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0)
                                    ),
                                    onPressed: ()
                                    {
                                      Get.back();
                                    },
                                    child: Text("no".tr,style: TextStyle(letterSpacing: 0.5,fontSize: 16),),
                                    color: Colors.grey[300],
                                  ),
                                  MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0)
                                    ),
                                    onPressed: () async
                                    {
                                      final SharedPreferences prefers = await SharedPreferences.getInstance();
                                      Get.back();
                                      Get.find<UserController>().deleteMyAccount().then((value){
                                        if(value.isSuccess){
                                          prefers.clear();
                                          Get.offAllNamed(RouteHelper.getLoginRoute());
                                        }
                                      });
                                    },
                                    child: Text("yes".tr,
                                      style: TextStyle(letterSpacing: 0.5,fontSize: 16,color: Colors.white),),
                                    color: Colors.red,
                                  ),
                                ],
                              )));
                            },
                            leading: SvgPicture.asset(Images.svgDelete,width: 40,color: Colors.red,),
                            title: Text("delete_account".tr,style: TextStyle(fontSize: 18,letterSpacing: 0.6,color: Colors.red),),
                            trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.red,),
                          ),
                        ],
                      ),*/
                ],
              ),
            ),
          );
        });
      }),
    );
  }

  Widget customList(String icon, String title, Function ontap) {
    return ListTile(
      dense: true,
      onTap: () {
        ontap();
      },
      leading: icon.contains(".png")
          ? Image.asset(icon, width: 18, height: 18, color: Color(0xff212020))
          : SvgPicture.asset(
              icon,
              width: 18,
              height: 18,
            ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff212020)),
      ),
    );
  }

  Widget customList1(String title, String title1, Function onTap) {
    return ListTile(
      onTap: () {
        onTap();
      },
      dense: true,
      title: Text(
        title,
        style: const TextStyle(color: Color(0xff212020), fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        title1,
        style: const TextStyle(color: Color(0xff667085), fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}
