import 'package:el_biz/bloc/post_ad/post_ad_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/data/model/base/company_filter_values_model.dart';
import 'package:el_biz/view/screen/filter/filter_screens/all_keywords_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../bloc/category/category_bloc.dart';
import '../../../../data/model/response/category/categories_list_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';
import '../../category/select_category_screen.dart';
import '../../cities/cities_page.dart';

class CompanyFilterScreen extends StatefulWidget {
  const CompanyFilterScreen({super.key});

  @override
  State<CompanyFilterScreen> createState() => _CompanyFilterScreenState();
}

class _CompanyFilterScreenState extends State<CompanyFilterScreen> {
  int value = 0;
  int price = 100;
  // final TextEditingController _minController = TextEditingController();
  // final TextEditingController _maxController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  CategoryItem? selectedCategory;

  // List<Map> sort = [
  //   {
  //     "value": "popular",
  //     "type": "popular".tr,
  //   },
  //   {
  //     "value": "latest",
  //     "type": "newest_first".tr,
  //   },
  //   {
  //     "value": "low-high",
  //     "type": "cheapest_first".tr,
  //   },
  //   {
  //     "value": "high-low",
  //     "type": "expensive_first".tr,
  //   },
  // ];

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

  void reset() {
    setState(() {
      selectedCategory = null;
    });
    context.read<ProductBloc>().add(ResetSelectedKeyword());
    context.read<ProductBloc>().add(ResetSelectedMaterial());
    context.read<PublicCompanyBloc>().add(UpdateCompanyFilterEnable(false));
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final publicTenderBloc = context.read<PublicCompanyBloc>();
      if (publicTenderBloc.state.isFilterEnable) {
        updateFilterOptions(publicTenderBloc.state);
      }
    });
  }

  updateFilterOptions(PublicCompanyState publicProductState) {
    loadCategory(publicProductState);

    selectedRating =
        publicProductState.companyFilterValuesModel?.highRating ?? '';
    isVerifiedCompany =
        publicProductState.companyFilterValuesModel?.isVerified ?? false;

    setState(() {});
  }

  loadCategory(PublicCompanyState publicProductState) {
    final categoryItems = context.read<CategoryBloc>().state.categoryItem;
    if (publicProductState.companyFilterValuesModel?.categoryId != null &&
        publicProductState.companyFilterValuesModel!.categoryId != '') {
      for (var category in categoryItems) {
        if (publicProductState.companyFilterValuesModel?.categoryId
                .toString() ==
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
                                  // productController.selectedSubCatName == ""
                                  //     ? Text(
                                  //         "category".tr,
                                  //         style: h16.copyWith(
                                  //             color: ColorResources.darkGray),
                                  //       )
                                  //     : Text(
                                  //         productController.selectedSubCatName,
                                  //         style: normalTextStyle,
                                  //       ),
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
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'keywords'.tr,
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => AllKeywordsScreen());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Все',
                                    style: button16.copyWith(
                                        color: ColorResources.blue),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(Images.svgArrowForwardIcon),
                                ],
                              ),
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
                                        context.read<ProductBloc>().add(
                                            UpdateKeywordSelected(keyword));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: productController
                                                  .keywordsSelected(keyword)
                                              ? ColorResources.green
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 1,
                                              color: ColorResources.lgColor),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          keyword,
                                          style: body14.copyWith(
                                              color: productController
                                                      .keywordsSelected(keyword)
                                                  ? ColorResources.white
                                                  : ColorResources.gray),
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
                          'high_rating'.tr,
                          // 'Высокий рейтинг',
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
                              style:
                                  body16.copyWith(color: ColorResources.gray),
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
                      ListTile(
                        onTap: () {
                          setState(() {
                            isVerifiedCompany = !isVerifiedCompany;
                          });
                        },
                        title: Text(
                          'verified_company'.tr,
                          // 'Проверенная компания',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        subtitle: Text(
                          "companies_passed_moderation".tr,
                          // 'Компании прошедшие модерацию',
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
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              final productController = context.read<ProductBloc>().state;

              String keyword = productController.selectedKeywords.join(', ');

              print(
                  'this is category = ${selectedCategory?.name} and ${keyword} and ${selectedRating} and ${isVerifiedCompany} and ${productController.selectedCityName}');

              CompanyFilterValuesModel companyFilters =
                  CompanyFilterValuesModel(
                      categoryId: "${selectedCategory?.id ?? ''}",
                      keywords: keyword,
                      highRating: selectedRating,
                      city: productController.selectedCityName,
                      isVerified: isVerifiedCompany);

              context.read<PublicCompanyBloc>().add(FilterPublicCompanyProduct(
                  productFilterValuesModel: companyFilters, currentPage: 1));
              Get.back();
            },
            title: 'filters'.tr),
      ),
    );
  }
}
