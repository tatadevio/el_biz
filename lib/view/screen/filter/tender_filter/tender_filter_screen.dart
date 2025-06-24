import 'package:el_biz/bloc/post_ad/post_ad_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/data/model/base/tender_filter_values_model.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../bloc/category/category_bloc.dart';
import '../../../../bloc/public_tender/public_tender_bloc.dart';
import '../../../../data/model/response/category/categories_list_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';
import '../../category/select_category_screen.dart';
import '../../cities/cities_page.dart';

class TenderFilterScreen extends StatefulWidget {
  const TenderFilterScreen({super.key});

  @override
  State<TenderFilterScreen> createState() => _TenderFilterScreenState();
}

class _TenderFilterScreenState extends State<TenderFilterScreen> {
  int value = 0;
  int price = 100;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  CategoryItem? selectedCategory;
  RangeValues _priceRange = const RangeValues(1, 20000);
  final TextEditingController startingQuantityController =
      TextEditingController();
  final TextEditingController endingQuantityController =
      TextEditingController();

  List<String> profileTypes = [
    'Юридические лица',
    'Физические лица',
    'Все профили',
  ];
  String selectedProfileType = 'Юридические лица';

  void reset() {
    _minController.clear();
    _maxController.clear();
    setState(() {
      _priceRange = const RangeValues(1, 20000);
      selectedCategory = null;
    });
    context.read<ProductBloc>().add(ResetSelectedKeyword());
    context.read<ProductBloc>().add(ResetSelectedMaterial());
    context.read<PublicTenderBloc>().add(UpdateTenderFilterEnable(false));
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final publicTenderBloc = context.read<PublicTenderBloc>();
      if (publicTenderBloc.state.isFilterEnable) {
        updateFilterOptions(publicTenderBloc.state);
      }
    });
  }

  updateFilterOptions(PublicTenderState publicTenderState) {
    loadCategory(publicTenderState);
    _minController.text =
        publicTenderState.tenderFilterValuesModel?.minBudget ?? '1';
    _maxController.text =
        publicTenderState.tenderFilterValuesModel?.maxBudget ?? '20000';

    startingQuantityController.text =
        publicTenderState.tenderFilterValuesModel?.minQuantity ?? '';
    endingQuantityController.text =
        publicTenderState.tenderFilterValuesModel?.maxQuantity ?? '';

    selectedProfileType =
        publicTenderState.tenderFilterValuesModel?.profileType ?? '';
    setState(() {});
  }

  loadCategory(PublicTenderState publicTenderState) {
    final categoryItems = context.read<CategoryBloc>().state.categoryItem;
    // for (var already in widget.alreadySelected!) {
    if (publicTenderState.tenderFilterValuesModel?.categoryId != null &&
        publicTenderState.tenderFilterValuesModel!.categoryId != '') {
      for (var category in categoryItems) {
        if (publicTenderState.tenderFilterValuesModel?.categoryId.toString() ==
            category.id.toString()) {
          selectedCategory = category;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // var height = Get.height;
    // var width = Get.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "filter".tr,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Center(
            child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, productController) {
              return InkWell(
                onTap: () {
                  context.read<PostAdBloc>().add(AddCategoryName("", false));
                  context.read<PostAdBloc>().add(UpdateCategoryId("", ""));

                  reset();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "reset".tr,
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
          child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productController) {
            return BlocBuilder<PostAdBloc, PostAdState>(
                builder: (context, postAdState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 15),
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
                                  selectedCategory == null
                                      ? Text(
                                          "category".tr,
                                          style: h16.copyWith(
                                              color: ColorResources.darkGray),
                                        )
                                      : Text(
                                          selectedCategory!.name ?? '',
                                          style: normalTextStyle,
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (productController.filterCategories.isNotEmpty)
                                SizedBox(
                                  width: Get.width,
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,

                                    spacing: 8.0, // Horizontal spacing
                                    runSpacing: 8.0, // Vertical spacing

                                    children:
                                        productController.filterCategories.map(
                                      (category) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 8),
                                              // margin: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: ColorResources
                                                          .lgColor),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    ColorResources.shadow1
                                                  ]),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    category.name,
                                                    style: body14,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(
                                                              RemoveFilterCategory(
                                                                  category));
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => SelectCategoryScreen(
                                            onSelect: (val) {
                                              setState(() {
                                                selectedCategory = val.first;
                                              });
                                              Get.back();
                                            },
                                            alreadySelected:
                                                selectedCategory != null
                                                    ? [selectedCategory!]
                                                    : [],
                                            isProductCategory: true,
                                            isCompanyCategory: false,
                                          ));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "all_categories".tr,
                                          style: button16.copyWith(
                                              color: ColorResources.blue),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(
                                            Images.svgArrowForwardIcon),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Количество',
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                                controller: startingQuantityController,
                                hintColor: 'от 5 шт',
                                inputType: TextInputType.numberWithOptions(),
                                leading: '',
                                readOnly: false),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomTextField(
                                controller: endingQuantityController,
                                hintColor: 'до 200 шт',
                                inputType: TextInputType.numberWithOptions(),
                                leading: '',
                                readOnly: false),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'profile_type'.tr,
                          // 'Высокий рейтинг',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileTypes.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<String>(
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            title: Text(
                              profileTypes[index],
                              style:
                                  body16.copyWith(color: ColorResources.gray),
                            ),
                            value: profileTypes[index],
                            groupValue: selectedProfileType,
                            onChanged: (value) {
                              setState(() {
                                selectedProfileType = value!;
                              });
                            },
                          );
                        },
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'city'.tr,
                          // 'Город',
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
                      BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, productcontroller) {
                        return InkWell(
                          onTap: () {
                            Get.bottomSheet(CitiesScreen(),
                                backgroundColor: Colors.white,
                                isScrollControlled: true);
                          },
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1, color: ColorResources.lgColor),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productcontroller.selectedCityName == ''
                                        ? 'select_city'.tr
                                        : productcontroller.selectedCityName,
                                    style: body16.copyWith(
                                        color: ColorResources.gray),
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
                      Text(
                        'Бюджет'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                      RangeSlider(
                        values: _priceRange,
                        min: 1,
                        max: 20000,
                        activeColor: ColorResources.green,
                        divisions: 195, // Optional for step control
                        labels: RangeLabels(
                          _priceRange.start.toInt().toString(),
                          _priceRange.end.toInt().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _priceRange = values;
                            _minController.text =
                                values.start.toInt().toString();
                            _maxController.text = values.end.toInt().toString();
                          });
                        },
                      ),
                      const SizedBox(height: 10),
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
                              onChanged: (val) {
                                final parsed = double.tryParse(val);
                                if (parsed != null &&
                                    parsed >= 500 &&
                                    parsed <= _priceRange.end) {
                                  setState(() {
                                    _priceRange =
                                        RangeValues(parsed, _priceRange.end);
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: _maxController,
                              hintColor: 'до 20 000 сом',
                              inputType: TextInputType.number,
                              leading: '',
                              readOnly: false,
                              maxLines: 1,
                              onChanged: (val) {
                                final parsed = double.tryParse(val);
                                if (parsed != null &&
                                    parsed >= _priceRange.start &&
                                    parsed <= 20000) {
                                  setState(() {
                                    _priceRange =
                                        RangeValues(_priceRange.start, parsed);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              final productController = context.read<ProductBloc>().state;

              // String keyword = productController.selectedKeywords.join(', ');

              print(
                  'this is category = ${selectedCategory?.name}  and ${selectedProfileType} and ${productController.selectedCityName}');

              TenderFilterValuesModel tenderFilters = TenderFilterValuesModel(
                categoryId: "${selectedCategory?.id ?? ''}",
                minQuantity: startingQuantityController.text,
                maxQuantity: endingQuantityController.text,
                profileType: selectedProfileType,
                city: productController.selectedCityName,
                minBudget: _minController.text,
                maxBudget: _maxController.text,
              );

              // print('this is the filter values ${tenderFilters.toJson()}');

              context.read<PublicTenderBloc>().add(FilterPublicTenderProduct(
                  productFilterValuesModel: tenderFilters, currentPage: 1));
              Get.back();
            },
            title: 'filters'.tr),
      ),
    );
  }
}
