import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:el_biz/data/model/base/product_filter_values_model.dart';
import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/category/select_category_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../../bloc/filter_fields/filter_fields_bloc.dart';
import '../../../../bloc/material/material_bloc.dart' as material;
import '../../../../data/model/base/rating_option_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';

class ProductsFilterScreen extends StatefulWidget {
  final bool isTenderFilter;
  const ProductsFilterScreen({super.key, this.isTenderFilter = false});

  @override
  State<ProductsFilterScreen> createState() => _ProductsFilterScreenState();
}

class _ProductsFilterScreenState extends State<ProductsFilterScreen> {
  // int value = 0;
  int price = 100;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  CategoryItem? selectedCategoryId;
  RangeValues _priceRange = const RangeValues(1, 20000);

  // List<String> ratingList = [
  //   'companies_rated_4_and_5',
  //   'companies_rated_2_and_3',
  //   'all_companies',
  // ];
  List<RatingOption> ratingOptions = [
    RatingOption(name: 'Rated 4 & 5 Stars', value: '45'),
    RatingOption(name: 'Rated 2 & 3 Stars', value: '23'),
    RatingOption(name: 'All Companies', value: 'all'),
  ];
  RatingOption selectedRating =
      RatingOption(name: 'All Companies', value: 'all');
  bool isVerifiedCompany = false;

  // List<String> colors = [
  //   "#F1A9A0",
  //   "#8E44AD",
  //   "#3498DB",
  //   "#2ECC71",
  //   "#E74C3C",
  //   "#F39C12",
  //   "#16A085",
  //   "#D35400",
  //   "#1ABC9C",
  //   "#34495E",
  // ];
  // String selectedColor = '';

  List<String> priceOptions = [
    'price_excuding_taxes',
    'price_including_VAT',
  ];
  String selectedPriceOption = '';

  // List<String> dimensions = [
  //   'L(40x56x40)',
  //   'S(40x56x40)',
  //   'XL(60x70x60)',
  //   'all_sizes'
  // ];
  // Map<String, bool> selectedDimensions = {};
  List<String> selectedDimensions = [];
  double priceSlider = 500;

  bool isHaveInSelectedDimensions(String dim) {
    if (selectedDimensions.contains(dim)) {
      return true;
    } else {
      return false;
    }
  }

  void updateSelectedDimensions(String dimension) {
    if (selectedDimensions.contains(dimension)) {
      selectedDimensions.remove(dimension);
    } else {
      selectedDimensions.add(dimension);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // for (var dimension in dimensions) {
    //   selectedDimensions[dimension] = false;
    // }
  }

  void reset() {
    setState(() {
      _priceRange = const RangeValues(1, 20000);
      selectedCategoryId = null;
      selectedDimensions = [];
      selectedPriceOption = '';
    });
    context.read<ProductBloc>().add(ResetSelectedKeyword());
    context.read<ProductBloc>().add(ResetSelectedMaterial());
    context.read<PublicProductBloc>().add(UpdateFilterEnable(false));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
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
                  // productController.updateNameId("", "");
                  // Get.find<PostAdController>().addCategoryName("", false);
                  // Get.find<PostAdController>().updateCategoryId("", "");
                  // Get.find<PostAdController>().attributeItem.clear();
                  // context
                  //     .read<PostAdBloc>()
                  //     .add(const AddCategoryName("", false));
                  // context
                  //     .read<PostAdBloc>()
                  //     .add(const UpdateCategoryId("", ""));
                  // productController.selectCurrency("");
                  // productController.changeCityId("", "");
                  // value = 0;
                  _minController.clear();
                  _maxController.clear();
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
            return BlocBuilder<FilterFieldsBloc, FilterFieldsState>(
              builder: (context, filterState) {
                if (filterState.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                                    selectedCategoryId == null
                                        ? Text(
                                            "category".tr,
                                            style: h16.copyWith(
                                                color: ColorResources.darkGray),
                                          )
                                        : Text(
                                            selectedCategoryId!.name ?? '',
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
                                if (productController
                                    .filterCategories.isNotEmpty)
                                  SizedBox(
                                    width: Get.width,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,

                                      spacing: 8.0, // Horizontal spacing
                                      runSpacing: 8.0, // Vertical spacing

                                      children: productController
                                          .filterCategories
                                          .map(
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
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                    boxShadow: const [
                                                      ColorResources.shadow1
                                                    ]),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                        // context
                                        //     .read<CategoryBloc>()
                                        //     .add(GetCategory());
                                        Get.to(() => SelectCategoryScreen(
                                              onSelect: (val) {
                                                setState(() {
                                                  selectedCategoryId =
                                                      val.first;
                                                });
                                                Get.back();
                                              },
                                              isProductCategory: true,
                                              isCompanyCategory: false,
                                            ));
                                        // Get.to(() => const MainCategories(
                                        //       type: true,
                                        //       fromHome: false,
                                        //       screenName: '/ProductsFilterScreen',
                                        //     ));
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
                        // category end
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        if (filterState.filterFieldsModel?.data != null) ...[
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'keywords'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Get.to(
                                  //   () => AddProduct4Screen(
                                  //     isEdit: false,
                                  //   ),
                                  // );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'all'.tr,
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
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,

                            spacing: 8.0, // Horizontal spacing
                            runSpacing: 8.0, // Vertical spacing
                            children:
                                // keywordsList
                                filterState.filterFieldsModel!.data!.searchTags!
                                    .map((keyword) => Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () {
                                                // productController.updateKeywordSelected(keyword);

                                                context.read<ProductBloc>().add(
                                                    UpdateKeywordSelected(
                                                        keyword.searchKeywords ??
                                                            ''));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                decoration: BoxDecoration(
                                                  color: productController
                                                          .keywordsSelected(
                                                              keyword.searchKeywords ??
                                                                  '')
                                                      ? ColorResources.green
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: ColorResources
                                                          .lgColor),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  keyword.searchKeywords ?? '',
                                                  style: body14.copyWith(
                                                      color: productController
                                                              .keywordsSelected(
                                                                  keyword.searchKeywords ??
                                                                      '')
                                                          ? ColorResources.white
                                                          : ColorResources
                                                              .gray),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                          ),
                        ],
                        // keyword.... selected_keyword
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'high_rating'.tr,
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ratingOptions.length,
                          itemBuilder: (context, index) {
                            return RadioListTile<RatingOption>(
                              contentPadding: const EdgeInsets.all(0),
                              dense: true,
                              title: Text(
                                ratingOptions[index].name.tr,
                                style:
                                    body16.copyWith(color: ColorResources.gray),
                              ),
                              value: ratingOptions[index],
                              groupValue: selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  selectedRating = value!;
                                });
                              },
                            );
                          },
                        ),

                        // rating end

                        const Divider(),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        BlocBuilder<material.MaterialBloc,
                            material.MaterialState>(
                          builder: (context, materialState) {
                            if (materialState.materialItems.isEmpty) {
                              return SizedBox();
                            }
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'material'.tr,
                                      style: h16.copyWith(
                                          color: ColorResources.darkGray),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'all'.tr,
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,

                                  spacing: 8.0, // Horizontal spacing
                                  runSpacing: 8.0, // Vertical spacing
                                  children: materialState.materialItems
                                      .map((material) => Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                onTap: () {
                                                  // productController.updateMaterialSelected(material);

                                                  context
                                                      .read<ProductBloc>()
                                                      .add(
                                                          UpdateMaterialSelected(
                                                              material.name ??
                                                                  ''));
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color: productController
                                                            .materialSelected(
                                                                material.name ??
                                                                    '')
                                                        ? ColorResources.green
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: ColorResources
                                                            .lgColor),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    material.name ?? '',
                                                    style: body14.copyWith(
                                                        color: productController
                                                                .materialSelected(
                                                                    material.name ??
                                                                        '')
                                                            ? ColorResources
                                                                .white
                                                            : ColorResources
                                                                .gray),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        // const Divider(),
                        // // select color
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 5),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'color'.tr,
                        //         style: h16.copyWith(
                        //             color: ColorResources.darkGray),
                        //       ),
                        //       Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Text(
                        //             'all'.tr,
                        //             style: button16.copyWith(
                        //                 color: ColorResources.blue),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           SvgPicture.asset(Images.svgArrowForwardIcon),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Wrap(
                        //   spacing: 8,
                        //   runSpacing: 8,
                        //   children: colors
                        //       .map(
                        //         (color) => InkWell(
                        //           borderRadius: BorderRadius.circular(28),
                        //           onTap: () {
                        //             setState(() {
                        //               selectedColor = color;
                        //             });
                        //           },
                        //           child: Container(
                        //             height: 28,
                        //             width: 28,
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: hexToColor(color),
                        //               border: Border.all(
                        //                   color: ColorResources.lgColor,
                        //                   width: 0.88),
                        //             ),
                        //             alignment: Alignment.center,
                        //             child: selectedColor == color
                        //                 ? const Icon(
                        //                     Icons.check,
                        //                     color: Colors.white,
                        //                   )
                        //                 : const SizedBox(),
                        //           ),
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                        const Divider(),
                        if (filterState.filterFieldsModel?.data?.dimentions !=
                                null &&
                            filterState.filterFieldsModel!.data!.dimentions!
                                .isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'dimensions'.tr,
                                  style: h16.copyWith(
                                      color: ColorResources.darkGray),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filterState
                                .filterFieldsModel!.data!.dimentions!.length,
                            itemBuilder: (context, index) {
                              String dimension = filterState
                                  .filterFieldsModel!.data!.dimentions![index];
                              return CheckboxListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.all(0),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: ColorResources.primary,
                                title: Text(
                                  dimension.tr,
                                  style: body16.copyWith(
                                      color: ColorResources.darkGray),
                                ),
                                value: isHaveInSelectedDimensions(dimension),
                                // selectedDimensions[dimension],
                                onChanged: (bool? value) {
                                  updateSelectedDimensions(dimension);
                                  // setState(() {
                                  //   selectedDimensions[dimension] =
                                  //       value ?? false;
                                  // });
                                },
                              );
                            },
                          ),
                          const Divider(),
                        ],

                        //price options
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'price1'.tr,
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
                                priceOptions[index].tr,
                                style:
                                    body16.copyWith(color: ColorResources.gray),
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 5),
                        //   child: Text(
                        //     'price'.tr,
                        //     style: h16.copyWith(color: ColorResources.darkGray),
                        //   ),
                        // ),
                        // Slider(
                        //   activeColor: ColorResources.green,
                        //   value: priceSlider,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       priceSlider = value;
                        //     });
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: CustomTextField(
                        //         controller: _minController,
                        //         hintColor: 'от 500 сом',
                        //         inputType: TextInputType.number,
                        //         leading: '',
                        //         readOnly: false,
                        //         maxLines: 1,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Expanded(
                        //       child: CustomTextField(
                        //         controller: _maxController,
                        //         hintColor: 'до 20 000 сом',
                        //         inputType: TextInputType.number,
                        //         leading: '',
                        //         readOnly: false,
                        //         maxLines: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // price session

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'price'.tr,
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
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
                              _maxController.text =
                                  values.end.toInt().toString();
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
                                      _priceRange = RangeValues(
                                          _priceRange.start, parsed);
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        // end price session

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
                        Text(
                          'currency'.tr,
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                context
                                    .read<ProductBloc>()
                                    .add(const ChangeCurrency('KGS'));
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: productController.selectedCurrency ==
                                            'KGS'
                                        ? ColorResources.green
                                        : ColorResources.lgColor,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'KGS',
                                  style: body16.copyWith(
                                      color: ColorResources.gray),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                context
                                    .read<ProductBloc>()
                                    .add(const ChangeCurrency('USD'));
                              },
                              child: Container(
                                width: width * 0.4,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: productController.selectedCurrency ==
                                            'USD'
                                        ? ColorResources.green
                                        : ColorResources.lgColor,
                                    //  ColorResources.green,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'USD',
                                  style: body16.copyWith(
                                      color: ColorResources.gray),
                                ),
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
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: widget.isTenderFilter
                ? () {
                    showShortToast('Не завершено');
                  }
                : () {
                    final productState = context.read<ProductBloc>().state;
                    // selectedCategory
                    // print(
                    //     'this is the filter data ${selectedCategoryId?.name} and keyword = ${context.read<ProductBloc>().state.selectedKeywords} rating = $selectedRating');
                    // print(
                    //     'selected material = ${productState.selectedMaterial} and color =${selectedColor} , Dimensions = ${selectedDimensions} , price = ${selectedPriceOption} ');
                    // print(
                    //     'sected price range = ${_priceRange.start}, and ${_priceRange.end}');

                    String keyword = context
                        .read<ProductBloc>()
                        .state
                        .selectedKeywords
                        .join(', ');
                    String material = productState.selectedMaterial.join(', ');
                    String dimensions = selectedDimensions.join(', ');

                    ProductFilterValuesModel productFilterValuesModel =
                        ProductFilterValuesModel(
                      categoryId: "${selectedCategoryId?.id ?? ''}",
                      keywords: keyword,
                      highRating: selectedRating.value,
                      materials: material,
                      dimensions: dimensions,
                      price: selectedPriceOption,
                      priceMin: _priceRange.start.toStringAsFixed(2),
                      priceMax: _priceRange.end.toStringAsFixed(2),
                    );

                    context.read<PublicProductBloc>().add(FilterPublicProduct(
                        productFilterValuesModel: productFilterValuesModel,
                        currentPage: 1));
                    Get.back();
                  },
            title: 'filter'.tr),
      ),
    );
  }
}
