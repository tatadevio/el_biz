import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../controller/post_ad_controller.dart';
import '../../../../controller/product_controller.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';
import '../../category/main_categories.dart';
import '../../cities/cities_page.dart';

class CompanyFilterScreen extends StatefulWidget {
  const CompanyFilterScreen({super.key});

  @override
  State<CompanyFilterScreen> createState() => _CompanyFilterScreenState();
}

class _CompanyFilterScreenState extends State<CompanyFilterScreen> {
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
    // var width = Get.width;
    return Scaffold(
      appBar: AppBar(
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
                                            fromHome: true,
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
                      GetBuilder<ProductController>(builder: (productcontroller) {
                        return InkWell(
                          onTap: () {
                            Get.bottomSheet(CitiesScreen(), backgroundColor: Colors.white, isScrollControlled: true);
                          },
                          child: Container(
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
                                    productcontroller.selectedCityName == '' ? 'Бишкек' : productcontroller.selectedCityName,
                                    style: body16.copyWith(color: ColorResources.gray),
                                  ),
                                ),
                                SvgPicture.asset(
                                  Images.svgArrowRight,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),

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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(width: Get.width, height: 44, onTap: () {}, title: 'filters'.tr),
      ),
    );
  }
}
