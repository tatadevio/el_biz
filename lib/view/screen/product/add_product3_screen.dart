import 'dart:io';

import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/data/model/base/add_product_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/product/add_product4_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/add_product/add_product_bloc.dart';
import '../../../utils/Images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';

class AddProduct3Screen extends StatefulWidget {
  // final AddProductModel addProductData;
  final bool isEdit;
  const AddProduct3Screen({super.key, required this.isEdit});

  @override
  State<AddProduct3Screen> createState() => _AddProduct3ScreenState();
}

class _AddProduct3ScreenState extends State<AddProduct3Screen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  List<TextEditingController> sizeController = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      updateProductData();
    }
  }

  addNewSize() {
    setState(() {
      sizeController.add(TextEditingController());
    });
  }

  removeSize(int index) {
    setState(() {
      sizeController[index].dispose();
      sizeController.removeAt(index);
    });
  }

  updateProductData() {
    descriptionController.text = 'updated description here';
    keywordsController.text = 'keyword keyword2';
    for (int i = 0; i < sizeController.length; i++) {}
    // sizeController.text = '12/32';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'photo'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'next_you_can_add_a_photo_of_your_product'.tr,
                  style: body14,
                ),
                const SizedBox(
                  height: 10,
                ),
                //selected image
                if (productController.pickedLogo.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: productController.pickedLogo
                        .map(
                          (image) => Stack(
                            children: [
                              ClipRRect(
                                // height: 80,
                                // width: 80,
                                borderRadius: BorderRadius.circular(12),

                                child: Image.file(
                                  File(image.path),
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // productController.removeGallery(image);
                                  context
                                      .read<ProductBloc>()
                                      .add(RemoveGallery(image));
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                    child: SvgPicture.asset(Images.svgTrash),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.dialog(CustomDialog(
                            widget: SimpleDialog(
                          backgroundColor: Colors.white,
                          title: Row(
                            children: [
                              Expanded(child: Text('select_image'.tr)),
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              onTap: () {
                                Get.back();
                                // productController.pickImageDocsCamera();
                                context
                                    .read<ProductBloc>()
                                    .add(PickImageDocsCamera());
                              },
                              leading: const Icon(Icons.camera),
                              title: Text('camera'.tr),
                            ),
                            ListTile(
                              onTap: () {
                                Get.back();
                                // productController.pickImageDocs();
                                context
                                    .read<ProductBloc>()
                                    .add(PickImageDocs());
                              },
                              leading: const Icon(Icons.image),
                              title: Text('gallery'.tr),
                            ),
                          ],
                        )));
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorResources.lgColor),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          Images.svgPlus,
                          height: 32,
                          width: 32,
                          color: ColorResources.gray,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'description'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'brief_description_of_the_product'.tr,
                  style: body14,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: descriptionController,
                    hintColor: 'description'.tr,
                    inputType: TextInputType.text,
                    leading: '',
                    readOnly: false),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'search_keywords_tags'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Введите через запятую ключевые слова и синонимы по которым будут искать ваш товар. Например: Мебель для дома, диваны, стулья, кресло, комод, стол...',
                  style: body14,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    controller: keywordsController,
                    hintColor: 'keywords'.tr,
                    inputType: TextInputType.text,
                    leading: '',
                    readOnly: false),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'size'.tr,
                  style: h16.copyWith(color: ColorResources.darkGray),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sizeController.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            if (index != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      removeSize(index);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            CustomTextField1(
                              controller: sizeController[index],
                              hintColor: 'Например: 80/90/67',
                              inputType: TextInputType.text,
                              lableText: '00/00/00',
                              leading: '',
                              readOnly: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\/?\d*\/?\d*'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonWithIcon(
                  title: 'add_size'.tr,
                  svgIcon: Images.svgPlus,
                  svgIconColor: ColorResources.gray,
                  textColor: ColorResources.gray,
                  buttonColor: ColorResources.lgColor,
                  borderColor: ColorResources.lgColor,
                  isMaxSize: false,
                  onTap: () {
                    addNewSize();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              List<String> allSize = [];
              for (int i = 0; i < sizeController.length; i++) {
                allSize.add(sizeController[i].text);
              }

              final productData = context.read<AddProductBloc>().state.productData;
              productData?.description = descriptionController.text;
              productData?.keywords = keywordsController.text;
              productData?.size = allSize;
              // AddProductModel productData = widget.addProductData.copyWith(
              //   description: descriptionController.text,
              //   keywords: keywordsController.text,
              //   size: allSize,
              // );
              Get.to(() => AddProduct4Screen(
                    // productData: productData,
                    isEdit: widget.isEdit,
                  ));
            },
            title: 'continue'.tr),
      ),
    );
  }
}
