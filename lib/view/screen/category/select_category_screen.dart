import 'package:el_biz/bloc/category/category_bloc.dart';
import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../base/custom_button.dart';
import '../../base/custom_image.dart';

class SelectCategoryScreen extends StatefulWidget {
  final Function(List<CategoryItem>)? onSelect;
  final bool isCompanyCategory;
  final bool isProductCategory;
  const SelectCategoryScreen(
      {super.key,
      this.onSelect,
      this.isCompanyCategory = false,
      this.isProductCategory = false});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  void _submitForm() {
    if (selectedCategories.isEmpty) {
      showShortToast('select_category'.tr);
    } else {
      if (widget.onSelect != null) {
        widget.onSelect!(selectedCategories); // pass the list back
      }
      // else if(widget.onSelect != null && widget.isProductCategory == true){
      //   wid
      // }
    }
  }

  List<CategoryItem> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isCompanyCategory
          ? customAddCompanyAppbar(title: '')
          : AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Категории'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  return Text(
                    'Выбрано: ${selectedCategories.length} из ${state.categoryItem.length}',
                    style: textStyle14Inter.copyWith(
                        color: ColorResources.gray,
                        fontWeight: FontWeight.w400),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                // print(
                //     'this is the lenght of the category items : ${state.categoryItem.length}');
                // if (state is CategoryLoading) {
                //   return const Center(child: CircularProgressIndicator());
                // }
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.categoryItem.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    final categoryItem = state.categoryItem[index];
                    return _buildCategoryItemWidget(categoryItem);
                    // return Container(
                    //   child: Text(''),
                    // );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              _submitForm();
            },
            title: 'continue'.tr),
      ),
    );
  }

  Widget _buildCategoryItemWidget(CategoryItem categoryItem) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          CustomImage(
            image: categoryItem.image ?? '',
            width: 24,
            height: 24,
            radius: 0,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              categoryItem.name ?? '',
              style: body16.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorResources.darkGray,
              ),
            ),
          ),
        ],
      ),
      // leading: Icon(Icons.category),
      controlAffinity: ListTileControlAffinity.leading,
      value: selectedCategories.contains(categoryItem),
      onChanged: (bool? value) {
        if (widget.isProductCategory) {
          selectedCategories = [];
          setState(() {
            selectedCategories.add(categoryItem);
            // if (selectedCategories.contains(categoryItem)) {
            //   selectedCategories.remove(categoryItem);
            // } else {
            //   selectedCategories.add(categoryItem);
            // }
          });
        } else {
          setState(() {
            if (selectedCategories.contains(categoryItem)) {
              selectedCategories.remove(categoryItem);
            } else {
              selectedCategories.add(categoryItem);
            }
          });
        }
        // print(isSelected);
      },
    );
  }
}
