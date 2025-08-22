import 'dart:io';

import 'package:el_biz/bloc/material/material_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/category/select_category_screen.dart';
import 'package:el_biz/view/screen/product/add_product4_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/add_product/add_product_bloc.dart';
import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../data/model/response/company/my_companies_model.dart';
import '../../../utils/Images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import '../auction/auctions/auctions_screen.dart';
import '../auction/new_auction/new_auction_screen.dart';
import '../tender/tender_screen.dart';
import 'preview_product_screen.dart';

class AddProduct3Screen extends StatefulWidget {
  // final AddProductModel addProductData;
  final bool isEdit;
  final bool isAuction;
  const AddProduct3Screen(
      {super.key, required this.isEdit, required this.isAuction});

  @override
  State<AddProduct3Screen> createState() => _AddProduct3ScreenState();
}

class _AddProduct3ScreenState extends State<AddProduct3Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
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
    final productDetail =
        context.read<ProductDetailBloc>().state.productDetailModel!.data!;
    descriptionController.text = productDetail.description ?? '';
    keywordsController.text = productDetail.searchKeywords ?? '';

    for (int i = 0; i < sizeController.length; i++) {}
    // sizeController.text = '12/32';
    context
        .read<AddProductBloc>()
        .add(GetCategoryById(productDetail.categoryId.toString()));
    // selectCompany();
    updateCompany(productDetail.company!);
  }

  void updateCompany(CompanyItem company) {
    final companyList = context.read<CompanyBloc>().state.myCompanies;

    CompanyItem? matchedCompany =
        companyList.firstWhereOrNull((c) => c.id == company.id);

    if (matchedCompany != null) {
      setState(() {
        context.read<AddProductBloc>().state.productData?.company =
            matchedCompany;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, addProductState) {
          return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productController) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                    // previous images
                    // ProductDetail
                    if (widget.isEdit) ...[
                      if (addProductState.productData?.productUploadedImages !=
                          null)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: addProductState
                              .productData!.productUploadedImages!
                              .map(
                                (image) => Stack(
                                  children: [
                                    ClipRRect(
                                      // height: 80,
                                      // width: 80,
                                      borderRadius: BorderRadius.circular(12),

                                      child: CustomImage(
                                          image: image.small ?? '',
                                          height: 80,
                                          width: 80,
                                          radius: 0),
                                      // Image.file(
                                      //   File(image.path),
                                      //   height: 80,
                                      //   width: 80,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<AddProductBloc>()
                                                  .add(RemoveProductImage(
                                                      image));
                                            },
                                            child: SvgPicture.asset(
                                                Images.svgTrash)),
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
                                        child:
                                            SvgPicture.asset(Images.svgTrash),
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
                      maxLines: 4,
                      readOnly: false,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                    ),
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
                        maxLines: 4,
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
                      height: 10,
                    ),

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
                    // select category
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'select_category'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        // context.read<CategoryBloc>().add(GetCategory());
                        Get.to(() => SelectCategoryScreen(
                              isProductCategory: true,
                              alreadySelected:
                                  addProductState.productData?.category == null
                                      ? []
                                      : [
                                          addProductState.productData!.category!
                                        ],
                              onSelect: (selectedCategories) {
                                context.read<AddProductBloc>().add(
                                    SelectCategory(
                                        category: selectedCategories.first));
                                Get.back();
                                print(
                                    'this is selected category = ${addProductState.productData?.category}');
                                context
                                    .read<MaterialBloc>()
                                    .add(GetMaterials(currentPage: 1));
                              },
                            ));
                      },
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: ColorResources.lgColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              addProductState.productData?.category == null
                                  ? 'select_category'.tr
                                  : addProductState
                                          .productData!.category?.name ??
                                      '',
                              style:
                                  body16.copyWith(color: ColorResources.gray),
                            )),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // select company
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'select_company'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    BlocBuilder<CompanyBloc, CompanyState>(
                      builder: (context, companyState) {
                        return Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: ColorResources.lgColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButton<CompanyItem>(
                            value: addProductState.productData?.company,
                            isExpanded: true,
                            hint: Text(
                              addProductState.productData?.company?.name ??
                                  'select_company'.tr,
                              style:
                                  body16.copyWith(color: ColorResources.gray),
                            ),
                            underline:
                                const SizedBox(), // Remove default underline
                            onChanged: context
                                        .read<UserBloc>()
                                        .state
                                        .selectedAccountModel!
                                        .isUser ==
                                    true
                                ? (CompanyItem? newValue) {
                                    setState(() {
                                      addProductState.productData?.company =
                                          newValue;
                                    });
                                  }
                                : null,
                            items: companyState.myCompanies
                                .map((CompanyItem city) {
                              return DropdownMenuItem<CompanyItem>(
                                value: city,
                                child: Text(city.name ?? '', style: body16),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          });
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final productData =
                    context.read<AddProductBloc>().state.productData;
                if (context.read<ProductBloc>().state.pickedLogo.isEmpty &&
                    !widget.isEdit) {
                  showShortToast('select_image'.tr);
                  return;
                }

                if (context.read<ProductBloc>().state.pickedLogo.isEmpty &&
                    widget.isEdit &&
                    (productData?.productUploadedImages == null ||
                        productData!.productUploadedImages!.isEmpty)) {
                  showShortToast('select_image'.tr);
                  return;
                }
                if (productData?.category == null) {
                  showShortToast('select_category'.tr);
                  return;
                }
                if (productData?.company == null) {
                  showShortToast('select_company'.tr);
                  return;
                }

                List<String> allSize = [];
                for (int i = 0; i < sizeController.length; i++) {
                  allSize.add(sizeController[i].text);
                }

                productData?.description = descriptionController.text;
                productData?.keywords = keywordsController.text;
                productData?.size = allSize;
                productData?.productImages =
                    context.read<ProductBloc>().state.pickedLogo;

                Get.to(() => AddProduct4Screen(
                      // productData: productData,
                      isEdit: widget.isEdit,
                      isAddProduct: true,
                      alreadySelected: widget.isEdit
                          ? context
                                  .read<ProductDetailBloc>()
                                  .state
                                  .productDetailModel!
                                  .data!
                                  .material ??
                              ''
                          : "",
                      onSelect: () {
                        Get.to(() => PreviewProductScreen(
                              // selectedMaterial: [],
                              // selectedMaterial: selectedMaterials,
                              // productData: widget.productData,
                              isEdit: widget.isEdit,
                              isAuction: widget.isAuction,
                            ));
                      },
                      isAuction: widget.isAuction,
                    ));
              }
            },
            title: 'continue'.tr),
      ),
    );
  }
}
