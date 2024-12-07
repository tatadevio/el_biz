import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../controller/post_ad_controller.dart';
import '../../../controller/product_controller.dart';
import '../../../data/model/response/product/add_attribute_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_textfield.dart';
import '../category/categories.dart';
import '../category/main_categories.dart';

class FilterCategory extends StatefulWidget {
  final bool fromHome;
  const FilterCategory({Key? key, required this.fromHome}) : super(key: key);

  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  int value = 0;
  int price = 100;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<Map> sort = [
    {
      "value": "popular",
      "type": "popular".tr,
    },
    {
      "value": "latest",
      "type": "newest_first".tr,
    },
    {
      "value": "low-high",
      "type": "cheapest_first".tr,
    },
    {
      "value": "high-low",
      "type": "expensive_first".tr,
    },
  ];

  List<String> keywordsList = [
    'Мебель',
    'Стол',
    'Садовая мебель',
    'Стулья',
    'Шкафы',
    'Светильник',
    'Светильник',
  ];

  List<String> ratingList = [
    'Компании с рейтингом 4 и 5',
    'Компании с рейтингом 2 и 3',
    'Все компании',
  ];
  String selectedRating = 'Компании с рейтингом 4 и 5';
  bool isVerifiedCompany = false;

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    var width = Get.width;
    return Scaffold(
      // backgroundColor: ColorResources.background,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: Text(
          "filter".tr,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Center(
            child: GetBuilder<ProductController>(builder: (productController) {
              return InkWell(
                onTap: () {
                  productController.updateNameId("", "");
                  Get.find<PostAdController>().addCategoryName("", false);
                  Get.find<PostAdController>().updateCategoryId("", "");
                  Get.find<PostAdController>().attributeItem.clear();
                  productController.selectCurrency("");
                  productController.changeCityId("", "");
                  value = 0;
                  _minController.clear();
                  _maxController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "reset".tr,
                    style: const TextStyle(
                      color: ColorResources.primary,
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: FormBuilder(
          key: _formKey,
          child: GetBuilder<ProductController>(builder: (productController) {
            return GetBuilder<PostAdController>(builder: (postAdController) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*SizedBox(
                          height: height * 0.05,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: TextFormField(
                              decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "what_searching_for".tr,
                                  filled: true,
                                  hintStyle: TextStyle(color:  ColorResources.blueGrey3),
                                  fillColor: ColorResources.greyLight.withOpacity(0.2),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(Images.search,color: ColorResources.blueGrey3),
                                  )
                              ),
                            ),
                          ),
                        ),*/
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.svgCategory,
                                    height: 21,
                                    width: 21,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  productController.selectedSubCatName == ""
                                      ? Text(
                                          "category".tr,
                                          style: h16.copyWith(color: ColorResources.darkGray),
                                        )
                                      : Text(
                                          productController.selectedSubCatName,
                                          style: normalTextStyle,
                                        ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 4),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorResources.background,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const MainCategories(
                                            type: true,
                                            fromHome: false,
                                          ));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "all_categories".tr,
                                          style: button16.copyWith(color: ColorResources.blue),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(Images.svgArrowForwardIcon),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ключевые слова',
                              style: h16.copyWith(color: ColorResources.darkGray),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Все',
                                  style: button16.copyWith(color: ColorResources.blue),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(Images.svgArrowForwardIcon),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,

                        spacing: 8.0, // Horizontal spacing
                        runSpacing: 8.0, // Vertical spacing
                        children: keywordsList
                            .map((keyword) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        productController.updateKeywordSelected(keyword);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: productController.keywordSelected(keyword) ? ColorResources.green : null,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(width: 1, color: ColorResources.lgColor),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          keyword,
                                          style: body14.copyWith(color: productController.keywordSelected(keyword) ? ColorResources.white : ColorResources.gray),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Высокий рейтинг',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ratingList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            title: Text(
                              ratingList[index],
                              style: body16.copyWith(color: ColorResources.gray),
                            ),
                            value: ratingList[index],
                            groupValue: selectedRating,
                            onChanged: (value) {
                              setState(() {
                                selectedRating = value!;
                              });
                            },
                          );
                        },
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Город',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                      ),
                      Text(
                        'Для выбора города начните вводить название в поле ниже, или выберите из списка.',
                        style: body14.copyWith(color: ColorResources.gray),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1, color: ColorResources.lgColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Бишкек',
                                style: body16.copyWith(color: ColorResources.gray),
                              ),
                            ),
                            SvgPicture.asset(
                              Images.svgArrowRight,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          setState(() {
                            isVerifiedCompany = !isVerifiedCompany;
                          });
                        },
                        title: Text(
                          'Проверенная компания',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        subtitle: Text(
                          'Компании прошедшие модерацию',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                        trailing: Switch(
                            activeColor: ColorResources.primary,
                            thumbColor: WidgetStateProperty.all(Colors.white),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: ColorResources.lgColor,
                            value: isVerifiedCompany,
                            onChanged: (val) {
                              setState(() {
                                isVerifiedCompany = val;
                              });
                            }),
                      ),

                      /////// old code

                      Container(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.svgLocation1,
                                    height: 21,
                                    width: 21,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  productController.selectedCityName == ''
                                      ? Text(
                                          "location".tr,
                                          style: normalTextStyle,
                                        )
                                      : Text(
                                          productController.selectedCityName,
                                          style: normalTextStyle,
                                        ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 4),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorResources.background,
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         Get.bottomSheet(
                              //           const CitiesScreen(),
                              //           isScrollControlled: true,
                              //         );
                              //       },
                              //       child: Text(
                              //         "change_location".tr,
                              //         style: normalTextStyle.copyWith(color: ColorResources.seeBlue),
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.dollarSignSvg,
                                    height: 21,
                                    width: 21,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "price".tr,
                                    style: normalTextStyle,
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 4),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorResources.background,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("price_from".tr, style: normalTextStyle),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // CustomTextField1(hintText: "min_price".tr, title: "min_price".tr, controller: _minController, line: 1, textInputType: TextInputType.number),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("price_to".tr, style: normalTextStyle),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // CustomTextField1(hintText: "max_price".tr, title: "max_price".tr, controller: _maxController, line: 1, textInputType: TextInputType.number),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.dollarSignSvg,
                                    height: 21,
                                    width: 21,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "year_of_issue".tr,
                                    style: normalTextStyle,
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 4),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorResources.background,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("year_from".tr, style: normalTextStyle),
                                        Text(
                                          "min".tr,
                                          style: normalTextStyle.copyWith(color: ColorResources.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("year_to".tr, style: normalTextStyle),
                                        Text(
                                          "max".tr,
                                          style: normalTextStyle.copyWith(color: ColorResources.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.calenderSvg,
                                    height: 21,
                                    width: 21,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "published".tr,
                                    style: normalTextStyle,
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0, bottom: 4),
                                child: Divider(
                                  thickness: 1,
                                  color: ColorResources.background,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    dense: true,
                                    trailing: value == index
                                        ? const Icon(
                                            Icons.done,
                                            color: ColorResources.blue,
                                          )
                                        : null,
                                    selectedTileColor: ColorResources.primary,
                                    onTap: () {
                                      productController.setSortType(sort[index]["value"]);
                                      setState(() {
                                        value = index;
                                      });
                                    },
                                    title: Text(
                                      sort[index]["type"],
                                      style: normalTextStyle.copyWith(
                                        color: value == index ? ColorResources.primary : ColorResources.black,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: sort.length,
                              ),
                            ],
                          ),
                        ),
                      ),
                      !productController.isCatLoading
                          ? Ink(
                              decoration: BoxDecoration(
                                gradient: ColorResources.primaryGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                minWidth: width * 0.9,
                                height: 48,
                                elevation: 0,
                                onPressed: () {
                                  postAdController.updateEmpty();
                                  if (postAdController.attributeItem.isNotEmpty) {
                                    _formKey.currentState!.saveAndValidate();
                                    for (int i = 0; i < postAdController.attributeItem.length; i++) {
                                      if (_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"] != null) {
                                        if (postAdController.attributeItem[i].type != "multiselect" && postAdController.attributeItem[i].type != "select") {
                                          if (postAdController.attributeItem[i].type == "integer") {
                                            postAdController.editAttributeInt(
                                                AddAttributeInt(_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"].toString(), postAdController.attributeItem[i].id.toString(), "", "from"), i.toString());
                                            postAdController.editAttributeInt(
                                                AddAttributeInt(_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i -new"].toString(), postAdController.attributeItem[i].id.toString(), "", "to"), i.toString());
                                          } else {
                                            postAdController.editAttribute(AddAttribute(_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"].toString(), postAdController.attributeItem[i].id.toString(), ""), i.toString(), false);
                                          }
                                        } else if (postAdController.attributeItem[i].type == "select") {
                                          List<String> res = "${_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"]}".split("_");
                                          postAdController.editAttribute(
                                              AddAttribute(res[0].replaceAll("[", ""), postAdController.attributeItem[i].id.toString(), postAdController.attributeItem[i].options[int.parse(res[1].replaceAll("]", ""))].name), i.toString(), false);
                                        } else if (postAdController.attributeItem[i].type == "multiselect") {
                                          List<String> value = [];
                                          List<String> ids = [];
                                          for (int j = 0; j < _formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"].length; j++) {
                                            List<String> res = "${_formKey.currentState!.value["${postAdController.attributeItem[i].id}_$i"][j]}".split("_");
                                            ids.add(res[0]);
                                            value.add(postAdController.attributeItem[i].options[int.parse(res[1])].name);
                                          }
                                          postAdController.editAttributeMulti(
                                              AddAttributeMulti(ids.toString().replaceAll("[", "").replaceAll("]", ""), postAdController.attributeItem[i].id.toString(), value.toString().replaceAll("[", "").replaceAll("]", "")), i.toString(), false);
                                        }
                                      }
                                    }
                                  }

                                  productController.getFilterProduct(_minController.text, _maxController.text).then((value) {
                                    if (value.isSuccess) {
                                      Get.back();
                                      if (widget.fromHome) {
                                        Get.to(() => Categories(
                                              title: productController.selectedSubCatName,
                                              categoryItem: [],
                                              id: productController.selectedSubCatId,
                                            ));
                                      }
                                    }
                                  });
                                },
                                // color: ColorResources.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  "filters".tr,
                                  style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            });
          }),
        ),
      ),
    );
  }

  Widget titleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget customOutlineTextField(String hintText, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.6))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.6))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.6))),
      ),
    );
  }

  Widget customList(String title, bool isSelected) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: normalTextStyle.copyWith(
          color: isSelected ? ColorResources.lightBlue : ColorResources.black,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.done,
              color: ColorResources.lightBlue,
            )
          : null,
    );
  }
}
