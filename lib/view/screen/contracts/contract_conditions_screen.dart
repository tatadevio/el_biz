import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractConditionsScreen extends StatefulWidget {
  const ContractConditionsScreen({super.key});

  @override
  State<ContractConditionsScreen> createState() =>
      _ContractConditionsScreenState();
}

class _ContractConditionsScreenState extends State<ContractConditionsScreen> {
  final TextEditingController nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  bool terms = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Text(
                      'contract_for_the_supply_of_goods'.tr,
                      textAlign: TextAlign.center,
                      style: h24.copyWith(
                        color: ColorResources.darkGray,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' ________________________________________________ в лице ________________________________________________, действующего на основании ________________________________________________, именуемый в дальнейшем «Поставщик», с одной стороны, и ________________________________________________ в лице ________________________________________________, действующего на основании ________________________________________________, именуемый в дальнейшем «Заказчик», с другой стороны, именуемые в дальнейшем «Стороны», заключили настоящий договор, в дальнейшем «Договор», о нижеследующем: ',
                    style: body14.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textTitle("1.", "subject_of_the_agreement".tr),
                  textDetail(
                      '1.1. В соответствии с условиями настоящего Договора Поставщик обязуется поставить товар надлежащего качества в количестве и в сроки, предусмотренные Договором, а Заказчик обязуется принять и оплатить за товар.\n1.2. Описание товара, его техническая спецификация, цена и общее количество товара, поставляемого по настоящему Договору, указаны в Приложении №1 к настоящему Договору (далее по тексту – «Товар»).\n1.3. Нижеследующие Приложения к настоящему Договору составляют неотъемлемую часть настоящего Договора и рассматриваются как единое целое:\n1.3.1. Приложение №1 «Счёт на оплату»'),
                  textTitle("2.", "contract_amount_and_payment_procedure".tr),
                  textDetail(
                      "2.1. Общая сумма Договора и цена за единицу Товара определены и включают в себя все применимые согласно законодательству Кыргызской Республики налоги, платежи, сборы, а также иные расходы Поставщика, прямо или косвенно связанные с исполнением им своих обязанностей по настоящему Договору (далее по тексту – «Сумма Договора»).\n2.2. В течение всего срока действия настоящего Договора цена за единицу Товара может изменяться только по обоюдному решению с составлением дополнительного договора.\n2.3. Стороны могут изменить Сумму Договора в соответствии с условиями п.11.2 настоящего Договора.\n2.4. Заказчик производит оплату за поставленный Товар на основании выставленного Поставщиком счета на оплату и подписанного обеими Сторонами договора поставки. 2.5. В случае, если Заказчик оспаривает сумму, указанную в счете-фактуре, выставленном Поставщиком, Заказчик обязан в письменной форме уведомить Поставщика о факте своего несогласия в течение 3 рабочих дней с даты получения счета-фактуры, при этом указывая причину своего несогласия. В таком случае Заказчик должен выплатить ту часть суммы, которую он не оспаривает, без задержки и не позднее 3-х рабочих дней с даты получения счёта на оплату. При достижении урегулирования спорных вопросов, Заказчик незамедлительно должен оплатить Поставщику согласованную сумму задолженности, в случае наличия таковой.\n2.6. Любая оплата, произведенная Заказчиком по настоящему Договору, считается произведенной при условии, что Заказчик сохраняет право в последующем оспорить правильность выставленных сумм.\n2.7. В случае если стоимость поставленного Товара по поданным заявкам не достигнет общей Суммы Договора, Поставщик не будет иметь право требовать с Заказчика предоставления заявок на оставшийся объем Товара и, соответственно, на оплату оставшегося размера Суммы Договора."),
                  textTitle("3.", "delivery_of_goods".tr),
                  textDetail(
                      "3.1. Если иное не предусмотрено соглашением Сторон, Товар поставляется заявке Заказчика (далее по тексту – «Заявка Заказчика»). В Заявке Заказчика должны быть указаны количество, ассортимент и цена поставляемого Товара.\n3.2. Поставщик обязан поставить Товар в пункт назначения согласно изъявленной в любой форме адреса Заказчика и нести все риски потери или повреждения Товара до момента его передачи Заказчику в Пункте назначения и подписания Акта приема-передачи Товара. Стороны по отношению к конкретной партии Товара, поставляемой по Заявке Заказчика, могут определить в качестве Пункта назначения иное место, чем это определено в Приложении №1 к настоящему Договору. Положение о пункте назначения, указанное в Заявке и согласованное сторонами, является неотъемлемой частью этой Заявки и имеет приоритет над положением о пункте назначения, указанном в Приложении №1 к настоящему Договору.\n3.3. Все расходы, связанные с транспортировкой Товара до Пункта назначения, обговариваются между сторонами.\n3.4. Поставщик обязан передать Заказчику Товар свободным от любых прав и притязаний третьих лиц. Неисполнение Поставщиком этой обязанности дает Заказчику право требовать уменьшения цены Товара либо расторжения Договора и возмещения убытков.\n3.5. Поставщик должен обеспечить упаковку Товара, способную предотвратить их от повреждения или порчи во время перевозки к Пункту назначения. Упаковка должна выдерживать без каких-либо ограничений, интенсивную подъемно-транспортную обработку и воздействие экстремальных температур, соли и осадков во время перевозки, а также открытого хранения. При определении габаритов упакованных ящиков и их веса необходимо учитывать отдаленность Пункта назначения и наличие мощных грузоподъемных средств во всех пунктах следования Товаров."),
                  // textTitle(
                  //   "",
                  //   "Подписание договора",
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'signing_the_contract'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "in_order_to_sign_the_contract_you_must_write_your_full_name"
                        .tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField1(
                    controller: nameController,
                    hintColor: 'full_name'.tr,
                    inputType: TextInputType.name,
                    lableText: "full_name_of_the_director".tr,
                    leading: "",
                    readOnly: false,
                    lableStyle: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CheckboxListTile(
                    value: terms,
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: ColorResources.primary,
                    onChanged: (value) {
                      setState(() {
                        terms = !terms;
                      });
                    },
                    title: Text(
                      'i_agree_to_the_terms_of_the_agreement...'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body14.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primary,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              Get.back();
            },
            title: 'ready'.tr),
      ),
    );
  }

  Widget textTitle(String point, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (point != '')
            Text(
              "$point ",
              style: h24.copyWith(color: ColorResources.darkGray),
            ),
          Expanded(
            child: Text(
              text,
              style: h24.copyWith(color: ColorResources.darkGray),
            ),
          ),
        ],
      ),
    );
  }

  Widget textDetail(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: body14.copyWith(color: ColorResources.darkGray),
      ),
    );
  }
}
