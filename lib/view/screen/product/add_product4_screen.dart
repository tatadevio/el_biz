import 'dart:developer';

import 'package:el_biz/bloc/add_product/add_product_bloc.dart';
import 'package:el_biz/data/model/response/materials_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/material/material_bloc.dart' as material;
import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product_detail/product_detail_bloc.dart';
import '../../base/custom_button.dart';
import '../dashboard/dashboard.dart';
import '../home/home_screen.dart';

class AddProduct4Screen extends StatefulWidget {
  // final AddProductModel productData;
  final bool isEdit;
  final Function()? onSelect;
  final bool? isAddProduct;
  final String alreadySelected;
  const AddProduct4Screen(
      {super.key,
      required this.isEdit,
      this.onSelect,
      this.isAddProduct,
      required this.alreadySelected});

  @override
  State<AddProduct4Screen> createState() => _AddProduct4ScreenState();
}

class _AddProduct4ScreenState extends State<AddProduct4Screen> {
  // final List<Map<String, dynamic>> materialData = [
  //   {"id": 1, "title": "Шпон дерева", "isChecked": false},
  //   {"id": 2, "title": "Камень", "isChecked": false},
  //   {"id": 3, "title": "Пластик", "isChecked": false},
  //   {"id": 4, "title": "ЛДСП", "isChecked": false},
  //   {"id": 5, "title": "МДФ", "isChecked": false},
  //   {"id": 6, "title": "Эпоксидная смола", "isChecked": false},
  //   {"id": 7, "title": "Гранит", "isChecked": false},
  //   {"id": 8, "title": "Мрамор", "isChecked": false},
  // ];

  // List<Map<String, dynamic>> selectedMaterials = [];

  //

  //

  @override
  void initState() {
    super.initState();
    if (widget.isEdit || widget.alreadySelected.isNotEmpty) {
      updateProductData();
    }
  }

  updateProductData() {
    if (widget.alreadySelected.isNotEmpty) {
      MaterialItem materialSelected = context
          .read<material.MaterialBloc>()
          .state
          .materialItems
          .firstWhere((e) =>
              e.name?.trim().toString() == widget.alreadySelected.toString());
      context.read<AddProductBloc>().add(SelectMaterial(materialSelected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('material'.tr),
      ),
      body: BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            HomeScreen().loadData(context);
            Get.offAll(() => const DashboardScreen());
            context.read<ProductBloc>().add(EmptyPickedLogo());
          } else if (state is AddProductFailure) {
            showCustomSnackBar(state.message);
          }
        },
        child: BlocListener<material.MaterialBloc, material.MaterialState>(
          listener: (context, stateListen) {
            if (stateListen is material.MaterialError) {
              showShortToast(stateListen.error);
            }
          },
          child: BlocBuilder<AddProductBloc, AddProductState>(
              builder: (context, addProductState) {
            return BlocBuilder<material.MaterialBloc, material.MaterialState>(
                builder: (context, materialState) {
              if (materialState.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final materialList = materialState.materialItems;
              return Padding(
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
                          materialList.length.toString(),
                          // '${"selected".tr}: ${materialData.where((item) => item['isChecked'] == true).length} ${"from".tr} ${materialData.length}',
                          style: body14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: materialList.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        ),
                        itemBuilder: (context, index) {
                          final materialItem = materialList[index];
                          return CheckboxListTile(
                            dense: false,
                            contentPadding: const EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: ColorResources.primary,
                            title: Text(materialItem.name ?? ''),
                            value: materialItem ==
                                addProductState.productData?.material,
                            onChanged: (val) {
                              if (widget.isAddProduct!) {
                                context
                                    .read<AddProductBloc>()
                                    .add(SelectMaterial(materialItem));
                              }
                            },
                            // onChanged: (bool? value) {
                            //   for (var item in materialData) {
                            //     item['isChecked'] = false;
                            //   }
                            //   setState(() {
                            //     materialData[index]['isChecked'] = true;
                            //   });

                            //   context
                            //       .read<AddProductBloc>()
                            //       .state
                            //       .productData
                            //       ?.material = materialData[index]['title'];
                            // },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
          }),
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
                  widget.onSelect!();
                  // selectedMaterials = [];
                  // selectedMaterials = materialData
                  //     .where((item) => item['isChecked'] == false)
                  //     .toList();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: BlocBuilder<AddProductBloc, AddProductState>(
                  builder: (context, addProductState) {
                if (addProductState is AddProductLoading) {
                  return CustomButtonLoader(
                      width: Get.width, height: Get.height);
                }
                return CustomButton(
                    width: Get.width,
                    height: Get.height,
                    onTap: () {
                      if (context
                              .read<AddProductBloc>()
                              .state
                              .productData
                              ?.material ==
                          null) {
                        showCustomSnackBar('select_material'.tr);
                        return;
                      }

                      if (widget.isEdit) {
                        // showCustomSnackBar('Product Updated....');
                        // Get.offAll(() => const DashboardScreen());
                        log('this is product data ${context.read<AddProductBloc>().state.productData}');
                        context.read<AddProductBloc>().add(UpdateProduct(
                            context.read<AddProductBloc>().state.productData!,
                            context
                                .read<ProductDetailBloc>()
                                .state
                                .productDetailModel!
                                .data!
                                .id
                                .toString()));
                      } else {
                        // showCustomSnackBar('Product Added');

                        log('this is product data ${context.read<AddProductBloc>().state.productData}');
                        context.read<AddProductBloc>().add(AddProduct(
                            addProductModel: context
                                .read<AddProductBloc>()
                                .state
                                .productData!));
                        // Get.offAll(() => const DashboardScreen());
                      }
                      // widget.onSelect!();
                      // selectedMaterials = [];
                      // selectedMaterials = materialData
                      //     .where((item) => item['isChecked'] == false)
                      //     .toList();
                    },
                    title: 'save'.tr);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
