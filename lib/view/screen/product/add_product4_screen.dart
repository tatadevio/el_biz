import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/screen/product/preview_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/base/add_product_model.dart';
import '../../base/custom_button.dart';

class AddProduct4Screen extends StatefulWidget {
  final AddProductModel productData;
  final bool isEdit;
  const AddProduct4Screen(
      {super.key, required this.productData, required this.isEdit});

  @override
  State<AddProduct4Screen> createState() => _AddProduct4ScreenState();
}

class _AddProduct4ScreenState extends State<AddProduct4Screen> {
  final List<Map<String, dynamic>> materialData = [
    {"id": 1, "title": "Шпон дерева", "isChecked": false},
    {"id": 2, "title": "Камень", "isChecked": false},
    {"id": 3, "title": "Пластик", "isChecked": false},
    {"id": 4, "title": "ЛДСП", "isChecked": false},
    {"id": 5, "title": "МДФ", "isChecked": false},
    {"id": 6, "title": "Эпоксидная смола", "isChecked": false},
    {"id": 7, "title": "Гранит", "isChecked": false},
    {"id": 8, "title": "Мрамор", "isChecked": false},
  ];

  List<Map<String, dynamic>> selectedMaterials = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      updateProductData();
    }
  }

  updateProductData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new_product'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'select_material'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                ),
                Text(
                  '${"selected".tr}: ${materialData.where((item) => item['isChecked'] == true).length} ${"from".tr} ${materialData.length}',
                  style: body14,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: materialData.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      dense: false,
                      contentPadding: const EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: ColorResources.primary,
                      title: Text(
                        materialData[index]['title'],
                      ),
                      value: materialData[index]['isChecked'],
                      onChanged: (bool? value) {
                        setState(() {
                          materialData[index]['isChecked'] = value ?? false;
                        });
                      });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: CustomBorderButton(
                height: Get.height,
                width: Get.width,
                padding: const EdgeInsets.all(0),
                border: Border.all(width: 1, color: ColorResources.blue),
                borderRadius: BorderRadius.circular(12),
                boxShaow: const [ColorResources.shadow1],
                child: Text(
                  'preview'.tr,
                  style: textMd.copyWith(color: ColorResources.blue),
                ),
                onTap: () {
                  selectedMaterials = [];
                  selectedMaterials = materialData
                      .where((item) => item['isChecked'] == false)
                      .toList();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                  width: Get.width,
                  height: Get.height,
                  onTap: () {
                    selectedMaterials = [];
                    selectedMaterials = materialData
                        .where((item) => item['isChecked'] == false)
                        .toList();
                    Get.to(() => PreviewProductScreen(
                          selectedMaterial: selectedMaterials,
                          productData: widget.productData,
                          isEdit: widget.isEdit,
                        ));
                  },
                  title: 'save'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
