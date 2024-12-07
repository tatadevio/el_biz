import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../utils/Images.dart';

class DeleteCompanyScreen extends StatefulWidget {
  const DeleteCompanyScreen({super.key});

  @override
  State<DeleteCompanyScreen> createState() => _DeleteCompanyScreenState();
}

class _DeleteCompanyScreenState extends State<DeleteCompanyScreen> {
  final TextEditingController otherTextController = TextEditingController();
  List deleteReason = [
    'Зарегистрировались по ошибке',
    'Компания прекратила деятельность',
    'Больше не хотите пользоваться нашим сервисом',
    'Другое',
  ];
  String selectedReason = 'Зарегистрировались по ошибке';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Удаление профиля Садовая мебель Loft',
                style: h24.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Нам очень жаль что вы удаляете свой профиль  с приложения. Пожалуйста, укажите причину своего решения. Мы делаем все  чтобы наша платформа была полезна пользователям.  Возможно, именно ваш отзыв поможет улучшить наш сервис.  Спасибо что были с нами.',
                style: body14.copyWith(color: ColorResources.gray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Причина',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: deleteReason.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      deleteReason[index],
                      style: body16.copyWith(color: ColorResources.gray),
                    ),
                    value: deleteReason[index],
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value!;
                      });
                    },
                  );
                },
              ),
              if (selectedReason == 'Другое') ...[
                CustomTextField(
                  controller: otherTextController,
                  hintColor: 'Напишите свой комментарий',
                  inputType: TextInputType.text,
                  leading: '',
                  readOnly: false,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Обязательное поле',
                  style: body12.copyWith(color: ColorResources.green),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButtonWithIcon(
          onTap: () {},
          title: 'Продолжить',
          svgIcon: Images.svgTrash,
          textColor: Colors.white,
          svgIconColor: Colors.white,
          buttonColor: ColorResources.red,
          borderColor: ColorResources.red,
          isMaxSize: false,
        ),
      ),
    );
  }
}
