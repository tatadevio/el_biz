import 'package:flutter/material.dart';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class NoCompanyWidget extends StatelessWidget {
  const NoCompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.companiesIcon,
              width: width * 0.5,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Добавьте свою компанию,  и сотрудничайте  с проверенными компаниями',
          style: h24.copyWith(color: ColorResources.darkGray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        // Text(
        //   'После регистрации вашей компании  вы можете:',
        //   style: body16.copyWith(color: ColorResources.gray),
        // ),
        RichText(
          text: TextSpan(
            style: body16.copyWith(color: ColorResources.gray, height: 1.6),
            children: const [
              TextSpan(text: 'После регистрации вашей компании  вы можете:\n'),
              TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Создавать тендера\n'),
              TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Заключать договоры с покупателями\n'),
              TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Загружать свои товары и продавать их на нашей платформе'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
