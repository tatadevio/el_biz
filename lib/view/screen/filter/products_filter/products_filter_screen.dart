import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/utils/utilities.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../bloc/post_ad/post_ad_bloc.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';
import '../../category/main_categories.dart';

class ProductsFilterScreen extends StatefulWidget {
  const ProductsFilterScreen({super.key});

  @override
  State<ProductsFilterScreen> createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {
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
  List<String> materialList = [
    'Дерево',
    'Пластик',
    'Железо',
    'Камень',
    'Текстиль',
    'ЛДСП',
    'МДФ',
    'Стекло',
    'Эпоксидная смола',
    'Плитка',
  ];

  List<String> ratingList = [
    'Компании с рейтингом 4 и 5',
    'Компании с рейтингом 2 и 3',
    'Все компании',
  ];
  String selectedRating = 'Компании с рейтингом 4 и 5';
  bool isVerifiedCompany = false;

  List<String> colors = [
    "#F1A9A0",
    "#8E44AD",
    "#3498DB",
    "#2ECC71",
    "#E74C3C",
    "#F39C12",
    "#16A085",
    "#D35400",
    "#1ABC9C",
    "#34495E",
  ];
  String selectedColor = '';

  List<String> priceOptions = [
    'Цена без учёта налогов',
    'Цена включая НДС',
  ];
  String selectedPriceOption = '';

  List<String> dimensions = ['L(40x56x40)', 'S(40x56x40)', 'XL(60x70x60)', 'Все размеры'];
  Map<String, bool> selectedDimensions = {};
  double priceSlider = 0.5;

  @override
  void initState() {
    super.initState();
    for (var dimension in dimensions) {
      selectedDimensions[dimension] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "filter".tr,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Center(
            child: BlocBuilder<ProductBloc, ProductState>(builder: (context, productController) {
              return InkWell(
                onTap: () {
                  // productController.updateNameId("", "");
                  // Get.find<PostAdController>().addCategoryName("", false);
                  // Get.find<PostAdController>().updateCategoryId("", "");
                  // Get.find<PostAdController>().attributeItem.clear();
                  context.read<PostAdBloc>().add(AddCategoryName("", false));
                  context.read<PostAdBloc>().add(UpdateCategoryId("", ""));
                  // productController.selectCurrency("");
                  // productController.changeCityId("", "");
                  value = 0;
                  _minController.clear();
                  _maxController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Сбросить".tr,
                    style: button16.copyWith(color: ColorResources.red),
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
          child: BlocBuilder<ProductBloc, ProductState>(builder: (context, productController) {
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
                                      // productController.updateKeywordSelected(keyword);

                                      context.read<ProductBloc>().add(UpdateKeywordSelected(keyword));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: productController.keywordsSelected(keyword) ? ColorResources.green : null,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 1, color: ColorResources.lgColor),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        keyword,
                                        style: body14.copyWith(color: productController.keywordsSelected(keyword) ? ColorResources.white : ColorResources.gray),
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
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Материал',
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
                      children: materialList
                          .map((material) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      // productController.updateMaterialSelected(material);

                                      context.read<ProductBloc>().add(UpdateMaterialSelected(material));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: productController.materialSelected(material) ? ColorResources.green : null,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 1, color: ColorResources.lgColor),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        material,
                                        style: body14.copyWith(color: productController.materialSelected(material) ? ColorResources.white : ColorResources.gray),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    const Divider(),
                    // select color
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Цвет',
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: colors
                          .map(
                            (color) => InkWell(
                              borderRadius: BorderRadius.circular(28),
                              onTap: () {
                                setState(() {
                                  selectedColor = color;
                                });
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hexToColor(color),
                                  border: Border.all(color: ColorResources.lgColor, width: 0.88),
                                ),
                                alignment: Alignment.center,
                                child: selectedColor == color
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Размеры',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dimensions.length,
                      itemBuilder: (context, index) {
                        String dimension = dimensions[index];
                        return CheckboxListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: ColorResources.primary,
                          title: Text(
                            dimension,
                            style: body16.copyWith(color: ColorResources.darkGray),
                          ),
                          value: selectedDimensions[dimension],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedDimensions[dimension] = value ?? false;
                            });
                          },
                        );
                      },
                    ),
                    const Divider(),
                    //price options
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Стоимость',
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: priceOptions.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String>(
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          title: Text(
                            priceOptions[index],
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                          value: priceOptions[index],
                          groupValue: selectedPriceOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPriceOption = value!;
                            });
                          },
                        );
                      },
                    ),

                    const Divider(),
                    // select price
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Цена',
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    Slider(
                      activeColor: ColorResources.green,
                      value: priceSlider,
                      onChanged: (value) {
                        setState(() {
                          priceSlider = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _minController,
                            hintColor: 'от 500 сом',
                            inputType: TextInputType.number,
                            leading: '',
                            readOnly: false,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: _maxController,
                            hintColor: 'до 20 000 сом',
                            inputType: TextInputType.number,
                            leading: '',
                            readOnly: false,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    Text(
                      'Валюта',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: width * 0.4,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: ColorResources.green,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'KGS',
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                        ),
                        Container(
                          width: width * 0.4,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: ColorResources.lgColor,
                              //  ColorResources.green,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'USD',
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
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
