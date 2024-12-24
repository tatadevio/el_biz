import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/screen/company/company_page_screen.dart';
import 'package:el_biz/view/screen/company/widgets/fill_company_data_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base/custom_button_with_icon.dart';
import '../../base/custom_image.dart';

class MyCompaniesScreen extends StatelessWidget {
  const MyCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_companies'.tr,
          style: h16.copyWith(
            color: ColorResources.blackText,
          ),
        ),
        actions: const [
          AppbarNotificationButton(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const SizedBox(),
            // NoCompanyWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return myCompanyWidget();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButtonWithIcon(
          title: 'add_a_company'.tr,
          svgIcon: Images.svgPlus,
          borderColor: ColorResources.green,
          onTap: () {
            Get.back();

            Get.dialog(
              const CustomDialog(
                widget: AlertDialog(
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.all(0),
                  contentPadding: EdgeInsets.all(5),
                  content: Padding(
                    padding: EdgeInsets.all(0),
                    child: FillCompanyDataBox(),
                  ),
                ),
              ),
            );
            // Get.to(() => MyCompaniesScreen());
          },
        ),
      ),
    );
  }

  Widget myCompanyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(() => const CompanyPageScreen(
                isCompany: true,
              ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: ColorResources.lightBlue,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: -2,
                offset: Offset(0, 2),
                color: Color.fromRGBO(16, 24, 40, 0.05),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(image: '', height: 64, width: 64, radius: 64),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Садовая мебель Loft',
                          style: h16.copyWith(
                            color: const Color.fromRGBO(16, 24, 40, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ОсОО Исхаков',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Images.svgVerified),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                'Проверенный пользователь',
                                style: body14.copyWith(color: ColorResources.gray),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'В В2В: ',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  Text(
                    '12 окт. 2024',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
