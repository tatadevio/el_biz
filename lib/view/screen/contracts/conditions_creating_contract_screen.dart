import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/response/company/company_product_model.dart';
import '../../../data/model/response/tender/tender_item_model.dart';
import '../../base/custom_toast.dart';
import 'new_contract_screen.dart';

class ConditionsCreatingContractScreen extends StatefulWidget {
  final ProductListItem product;
  final TenderItem tenderItem;
  final String buyerId;
  final String type;
  final int companyId;
  const ConditionsCreatingContractScreen({
    super.key,
    required this.product,
    required this.tenderItem,
    required this.buyerId,
    required this.type,
    required this.companyId,
  });

  @override
  State<ConditionsCreatingContractScreen> createState() =>
      _ConditionsCreatingContractScreenState();
}

class _ConditionsCreatingContractScreenState
    extends State<ConditionsCreatingContractScreen> {
  bool _terms = false;

  final List<Section> point1And2 = [
    Section(
      number: '1',
      title: 'Предмет договора',
      subSections: [
        SubSection(
            number: '1.1',
            title:
                'Поставщик обязуется предоставить товар/услугу в соответствии с описанием, размещённым в приложении.'),
        SubSection(
            number: '1.2',
            title:
                'Покупатель обязуется принять и оплатить товар/услугу в соответствии с условиями договора.'),
      ],
    ),
    Section(
      number: '2',
      title: 'Оформление договора',
      subSections: [
        SubSection(
            number: '2.1',
            title:
                'Договор считается заключённым с момента подтверждения обеими сторонами условий, согласованных в приложении.'),
        SubSection(
            number: '2.2',
            title:
                'Электронная форма договора, созданная в приложении, имеет юридическую силу.'),
      ],
    ),
  ];

  final pint3 = Section(
    number: '3',
    title: 'Обязательства сторон',
    subSections: [
      SubSection(
        title: 'Поставщик обязуется:',
        bulletPoints: [
          'Предоставить товар/услугу в заявленные сроки.',
          'Обеспечить качество товара/услуги в соответствии с описанием.',
        ],
      ),
      SubSection(
        title: 'Покупатель обязуется:',
        bulletPoints: [
          'Оплатить товар/услугу в указанные сроки.',
          'Принять товар/услугу при выполнении всех условий договора.',
        ],
      ),
    ],
  );
  final point4To8 = [
    Section(
      number: '4',
      title: 'Условия оплаты',
      subSections: [
        SubSection(
            number: '4.1',
            title:
                'Оплата осуществляется в порядке, согласованном сторонами (предоплата, частичная оплата или постоплата).'),
        SubSection(
            number: '4.2',
            title:
                'В случае задержки оплаты покупатель обязан уведомить поставщика через приложение.'),
      ],
    ),
    Section(
      number: '5',
      title: 'Сроки поставки',
      subSections: [
        SubSection(
            number: '5.1',
            title:
                'Поставщик обязуется выполнить поставку в сроки, указанные в договоре.'),
        SubSection(
            number: '5.2',
            title:
                'Нарушение сроков поставки регулируется условиями возврата и компенсации, согласованными сторонами.'),
      ],
    ),
    Section(
      number: '6',
      title: 'Возврат и гарантия',
      subSections: [
        SubSection(
            number: '6.1',
            title:
                'Покупатель имеет право на возврат товара в течение установленного времени, если он не соответствует условиям договора.'),
        SubSection(
            number: '6.2',
            title:
                'Гарантия на предоставленные услуги/товары согласовывается отдельно.'),
      ],
    ),
    Section(
      number: '7',
      title: 'Разрешение споров',
      subSections: [
        SubSection(
            number: '7.1',
            title:
                'В случае возникновения споров стороны обязуются урегулировать их через переговоры.'),
        SubSection(
            number: '7.2',
            title:
                'Если спор не может быть разрешён, стороны обращаются в суд в соответствии с законодательством.'),
      ],
    ),
    Section(
      number: '8',
      title: 'Прекращение договора',
      subSections: [
        SubSection(
            number: '8.1',
            title:
                'Договор может быть расторгнут по соглашению сторон или в случае нарушения одной из сторон своих обязательств.'),
        SubSection(
            number: '8.2',
            title: 'Условия расторжения фиксируются в приложении.'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Условия создания нового договора и политика конфиденциальности',
              style: h24,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Прочитайте внимательно условия создания договора. ',
              style: body14.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            for (var section in point1And2) buildSection(section),
            buildSection(pint3),
            for (var section in point4To8) buildSection(section),
            const SizedBox(
              height: 15,
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                'Я ознакомлен и соглашаюсь с условиями создания договора.',
                style: body14.copyWith(color: ColorResources.darkGray),
              ),
              value: _terms,
              onChanged: (val) {
                setState(() {
                  _terms = val ?? false;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorResources.white,
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              if (_terms == false) {
                showShortToast('please_accept_the_terms_and_conditions'.tr);
                return;
              }
              Get.to(() => NewContractScreen(
                    product: widget.product,
                    tenderItem: widget.tenderItem,
                    buyerId: widget.buyerId,
                    type: widget.type,
                    companyId: widget.companyId,
                  ));
            },
            title: 'continue'.tr),
      ),
    );
  }

  Widget buildSection(Section section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${section.number}. ${section.title}',
          style: body14.copyWith(color: ColorResources.darkGray),
          // TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        ...section.subSections.map((sub) {
          if (sub.bulletPoints != null) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sub.title,
                    style: body14.copyWith(color: ColorResources.darkGray),
                    // TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  ...sub.bulletPoints!.map((point) => Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 4),
                        child: Text(
                          '• $point',
                        ),
                      )),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Text(
                '${sub.number}. ${sub.title}',
                style: body14.copyWith(color: ColorResources.darkGray),
              ),
            );
          }
        }),
        SizedBox(height: 12),
      ],
    );
  }
}

class Section {
  final String number;
  final String title;
  final List<SubSection> subSections;

  Section(
      {required this.number, required this.title, this.subSections = const []});
}

class SubSection {
  final String? number;
  final String title;
  final List<String>? bulletPoints;

  SubSection({this.number, required this.title, this.bulletPoints});
}
