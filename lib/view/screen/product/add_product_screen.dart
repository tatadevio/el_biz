import 'package:el_biz/data/model/base/add_product_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_product3_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  final TextEditingController dimensionsController = TextEditingController();
  TextEditingController dimensionsUnitController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  TextEditingController weightUnitController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  String? checkAvailibity;

  @override
  void initState() {
    super.initState();
    currencyController = TextEditingController(text: 'KGS');
    unitController = TextEditingController(text: 'шт');
    dimensionsUnitController = TextEditingController(text: 'см');
    weightUnitController = TextEditingController(text: 'кг');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новый товар'),
      ),
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
                'Бренд',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(controller: brandController, hintColor: '', inputType: TextInputType.text, lableText: 'Например: Loft', leading: '', readOnly: false),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(controller: productNameController, hintColor: '', inputType: TextInputType.text, lableText: 'Название товара', leading: '', readOnly: false),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(controller: productCodeController, hintColor: '', inputType: TextInputType.text, lableText: 'Артикул товара', leading: '', readOnly: false),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: CustomTextField1(
                        controller: priceController,
                        hintColor: '',
                        inputType: TextInputType.number,
                        lableText: 'Стоимость',
                        leading: '',
                        readOnly: false,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: CustomTextField1(
                        controller: currencyController,
                        hintColor: '',
                        inputType: TextInputType.none,
                        lableText: 'Валюта',
                        leading: '',
                        readOnly: true,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: CustomTextField1(
                        controller: quantityController,
                        hintColor: '',
                        inputType: TextInputType.number,
                        lableText: 'Количество',
                        leading: '',
                        readOnly: false,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: CustomTextField1(
                        controller: currencyController,
                        hintColor: '',
                        inputType: TextInputType.none,
                        lableText: 'Ед.изм',
                        leading: '',
                        readOnly: true,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RadioListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(0),
                value: 'Уточнять наличие',
                groupValue: checkAvailibity,
                onChanged: (val) {
                  setState(() {
                    checkAvailibity = val ?? '';
                  });
                },
                title: Text(
                  'Уточнять наличие',
                  style: body16.copyWith(color: ColorResources.darkGray),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Габариты в упаковке',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              Row(
                children: [
                  Expanded(flex: 6, child: CustomTextField1(controller: dimensionsController, hintColor: '', inputType: TextInputType.text, lableText: 'Д/Ш/В. Например: 23/45/60', leading: '', readOnly: false)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: CustomTextField1(
                        controller: currencyController,
                        hintColor: '',
                        inputType: TextInputType.none,
                        lableText: 'Ед.изм',
                        leading: '',
                        readOnly: true,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: CustomTextField1(
                        controller: weightController,
                        hintColor: '',
                        inputType: TextInputType.text,
                        lableText: 'Вес в упаковке',
                        leading: '',
                        readOnly: false,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 2,
                      child: CustomTextField1(
                        controller: weightUnitController,
                        hintColor: '',
                        inputType: TextInputType.none,
                        lableText: 'Ед.изм',
                        leading: '',
                        readOnly: true,
                        lableStyle: h16.copyWith(color: ColorResources.darkGray),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField1(
                controller: regionController,
                hintColor: '',
                inputType: TextInputType.text,
                lableText: 'Страна производства',
                leading: '',
                readOnly: false,
                lableStyle: h16.copyWith(color: ColorResources.darkGray),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              AddProductModel addProduct = AddProductModel(
                  brandName: brandController.text,
                  productName: productNameController.text,
                  productCode: productCodeController.text,
                  price: priceController.text,
                  currency: currencyController.text,
                  quantity: quantityController.text,
                  quantityUnit: unitController.text,
                  dimensions: dimensionsController.text,
                  dimensionsUnit: dimensionsUnitController.text,
                  weight: weightController.text,
                  weightUnit: weightUnitController.text,
                  region: regionController.text,
                  availability: checkAvailibity);

              Get.to(() => AddProduct3Screen(
                    addProductData: addProduct,
                  ));
            },
            title: 'Продолжить'),
      ),
    );
  }
}
