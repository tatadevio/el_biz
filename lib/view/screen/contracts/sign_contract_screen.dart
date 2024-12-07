import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignContractScreen extends StatefulWidget {
  const SignContractScreen({super.key});

  @override
  State<SignContractScreen> createState() => _SignContractScreenState();
}

class _SignContractScreenState extends State<SignContractScreen> {
  final TextEditingController directorNameController = TextEditingController();
  bool termsAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Согласование между',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Поставщик',
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Юр наименование',
                                style: body16.copyWith(color: ColorResources.titleColor),
                              ),
                              Text(
                                'ФИО директора',
                                style: body16.copyWith(color: ColorResources.titleColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Заказчик',
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Юр наименование',
                                style: body16.copyWith(color: ColorResources.titleColor),
                              ),
                              Text(
                                'ФИО директора',
                                style: body16.copyWith(color: ColorResources.titleColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Подписание договора',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Для того чтобы подписать договор, необходимо написать полное ФИО',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'ФИО Директора ',
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(controller: directorNameController, hintColor: 'ФИО', inputType: TextInputType.name, leading: '', readOnly: false),
                  CheckboxListTile(
                    value: termsAgreed,
                    onChanged: (val) {
                      termsAgreed = val!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                    activeColor: ColorResources.primary,
                    dense: true,
                    title: Text(
                      'Я соглашаюсь с условиями договора',
                      style: body14.copyWith(color: ColorResources.blackText),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Покупатель: ',
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                      Text(
                        'OcOO “Loft”',
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Вы получили электронный договор для подписания, если вы не согласны или вас не устраивают условия, отклоните подписание договора.',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBorderButton(
                    height: 44,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    border: Border.all(color: ColorResources.red, width: 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShaow: const [ColorResources.shadow1],
                    child: Text(
                      'Отклонить',
                      style: textMd.copyWith(color: ColorResources.red),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomButton(width: Get.width, height: 44, onTap: () {}, title: 'Подписать'),
      ),
    );
  }
}
