import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/custom_add_company_appbar.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final TextEditingController legalNameController = TextEditingController();
  final TextEditingController okpoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: "register company".tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Регистрация компании',
                style: h24.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Пожалуйста, потратьте несколько минут на правильное заполнение профиля компании.  Чем качественнее заполнена анкета, тем больше клиентов обратят на нее внимание.\nВсе анкеты после добавления проходят проверку модератором. Если анкета оформлена ненадлежащим образом или в тексте содержатся ошибки, анкета может быть заблокирована.',
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'ИНН НП: ',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  Text(
                    '03010201310131',
                    style: body14,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Название компании/бренда',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(controller: legalNameController, hintColor: 'Юр название: ОсОО исхаков', inputType: TextInputType.name, lableText: 'Юр название: ОсОО исхаков', leading: '', readOnly: false),
              const SizedBox(
                height: 5,
              ),
              Text(
                'optional_field'.tr,
                style: body12.copyWith(color: ColorResources.green),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(controller: okpoController, hintColor: 'ОКПО', inputType: TextInputType.name, lableText: 'ОКПО', leading: '', readOnly: false),
              const SizedBox(
                height: 5,
              ),
              Text(
                'optional_field'.tr,
                style: body12.copyWith(color: ColorResources.green),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Логотип компании/ организации',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: ColorResources.lgColor,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(Images.uploadImagePng),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Загрузить',
                        style: h16.copyWith(color: ColorResources.gray),
                      ),
                      Text(
                        'SVG, PNG, JPG',
                        style: textXS.copyWith(color: ColorResources.gray),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Баннер компании/ организации',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorResources.lgColor,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.imagePng,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Загрузить баннер',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                        Text(
                          'SVG, PNG, JPG',
                          style: textXS.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'optional_field'.tr,
                style: body12,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              Get.to(() => CompanyDescriptionScreen());
            },
            title: 'continue'.tr),
      ),
    );
  }
}
