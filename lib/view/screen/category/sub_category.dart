import 'package:el_biz/bloc/category/category_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/product_controller.dart';
import '../../../data/model/response/category/category_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import 'categories.dart';

class CategoryScreens extends StatefulWidget {
  final CategoriesItem category;
  final bool fromHome;

  const CategoryScreens({super.key, required this.category, this.fromHome = false});

  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  final List<CategoriesItem> _categoryStack = [];

  @override
  void initState() {
    super.initState();
    _categoryStack.add(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back navigation to the previous parent category
        if (_categoryStack.length > 1) {
          _categoryStack.removeLast();
          setState(() {});
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            _categoryStack.last.name,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            InkWell(
                onTap: () {
                  _categoryStack.clear();
                  Get.back();
                },
                child: const Center(
                    child: Icon(
                  Icons.close,
                  color: Colors.red,
                ))),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, categoryState) {
          return Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _categoryStack.last.childs.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              dense: true,
                              // leading: _categoryStack.last.childs[index].childs.isNotEmpty
                              //     ? null
                              //     : Checkbox(
                              //         value: categoryState.isFilterSelectedCategory(_categoryStack.last.childs[index]),
                              //         onChanged: (value) {
                              //           categoryState.updateFilterSelectedCategory(_categoryStack.last.childs[index]);
                              //           print(categoryState.filterCategories);
                              //         },
                              //       ),
                              title: Text(
                                _categoryStack.last.childs[index].name,
                                style: body16.copyWith(color: ColorResources.darkGray),
                              ),
                              onTap: () {
                                if (_categoryStack.last.childs[index].childs.isNotEmpty) {
                                  _categoryStack.add(_categoryStack.last.childs[index]);
                                  setState(() {});
                                } else {
                                  // Get.find<ProductController>().getProductWithCat(_categoryStack.last.childs[index].id.toString(),
                                  //     _categoryStack.last.childs[index].name);
                                  // Get.to(() => Categories(title: _categoryStack.last.childs[index].name,
                                  //   categoryItem: _categoryStack.last.childs,
                                  //   id: _categoryStack.last.childs[index].id.toString(),));

                                  Get.find<ProductController>().updateNameId(_categoryStack.last.childs[index].id.toString(), _categoryStack.last.childs[index].name, callProduct: widget.fromHome);

                                  if (!widget.fromHome) {
                                    Get.until((route) => route.settings.name == "/FilterCategory");
                                  } else {
                                    Get.to(() => Categories(
                                          title: _categoryStack.last.childs[index].name,
                                          categoryItem: _categoryStack.last.childs,
                                          id: _categoryStack.last.childs[index].id.toString(),
                                        ));
                                  }
                                }
                                // Navigate to the child category screen on tap
                              },
                              trailing: _categoryStack.last.childs[index].childs.isNotEmpty ? SvgPicture.asset(Images.svgArrowRight) : null,
                            ),
                            const Divider(
                              thickness: 2,
                              color: ColorResources.background,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
