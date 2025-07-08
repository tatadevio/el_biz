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
      title: 'contract_subject'.tr,
      subSections: [
        SubSection(number: '1.1', title: 'supplier_obligation'.tr),
        SubSection(number: '1.2', title: 'buyer_obligation'.tr),
      ],
    ),
    Section(
      number: '2',
      title: 'contract_execution'.tr,
      subSections: [
        SubSection(number: '2.1', title: 'contract_concluded'.tr),
        SubSection(number: '2.2', title: 'electronic_form_valid'.tr),
      ],
    ),
  ];

  final pint3 = Section(
    number: '3',
    title: 'parties_obligations'.tr,
    subSections: [
      SubSection(
        title: 'supplier_obligations'.tr,
        bulletPoints: [
          'provide_goods_services_timely'.tr,
          'ensure_quality'.tr,
        ],
      ),
      SubSection(
        title: 'buyer_obligations'.tr,
        bulletPoints: [
          'pay_goods_services_timely'.tr,
          'accept_goods_services'.tr,
        ],
      ),
    ],
  );
  final point4To8 = [
    Section(
      number: '4',
      title: 'payment_terms'.tr,
      subSections: [
        SubSection(number: '4.1', title: 'payment_procedure'.tr),
        SubSection(number: '4.2', title: 'payment_delay_notification'.tr),
      ],
    ),
    Section(
      number: '5',
      title: 'delivery_terms'.tr,
      subSections: [
        SubSection(number: '5.1', title: 'supplier_delivery_obligation'.tr),
        SubSection(number: '5.2', title: 'delivery_violation'.tr),
      ],
    ),
    Section(
      number: '6',
      title: 'return_and_warranty'.tr,
      subSections: [
        SubSection(number: '6.1', title: 'buyer_return_right'.tr),
        SubSection(number: '6.2', title: 'warranty_agreement'.tr),
      ],
    ),
    Section(
      number: '7',
      title: 'dispute_resolution'.tr,
      subSections: [
        SubSection(number: '7.1', title: 'negotiation_obligation'.tr),
        SubSection(number: '7.2', title: 'court_appeal'.tr),
      ],
    ),
    Section(
      number: '8',
      title: 'contract_termination'.tr,
      subSections: [
        SubSection(number: '8.1', title: 'contract_termination_conditions'.tr),
        SubSection(number: '8.2', title: 'termination_conditions_recorded'.tr),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'contract_conditions_and_privacy_policy'.tr,
              style: h24,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'read_contract_conditions_carefully'.tr,
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
                'i_agree_to_contract_conditions'.tr,
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
                showShortToast('please_accept_terms_and_conditions'.tr);
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
