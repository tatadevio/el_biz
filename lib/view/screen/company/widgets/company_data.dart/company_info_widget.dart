import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, state) {
      return Container(
        child: Text(
          state.companyDetailModel?.data?.aboutCompany ?? '',
          // 'Добро пожаловать в наш магазин мебели — место, где стиль и качество встречаются с комфортом и функциональностью. Мы предлагаем широкий ассортимент мебели для дома и офиса, которая создаст уют и подчеркнет ваш уникальный вкус. Наша команда тщательно отбирает каждую коллекцию, чтобы предложить вам современные и классические решения, изготовленные из высококачественных материалов. ',
          style: body14.copyWith(color: ColorResources.gray),
        ),
      );
    });
  }
}
