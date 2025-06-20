import 'dart:developer';
import 'dart:io';

import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/add_tender/add_tender_bloc.dart';
import '../../../bloc/public_tender/public_tender_bloc.dart';
import '../../../bloc/tenders/tenders_bloc.dart';
import '../../../bloc/tenders/tenders_event.dart';
import '../../../bloc/tenders/tenders_state.dart';
import '../../../data/model/base/add_tender_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/appConstant.dart';
import '../../base/custom_dialog.dart';
import '../category/select_category_screen.dart';
import '../dashboard/dashboard.dart';
import 'new_tender_preview_screen.dart';

class NewTende2Screen extends StatefulWidget {
  final bool isEdit;
  const NewTende2Screen({super.key, this.isEdit = false});

  @override
  State<NewTende2Screen> createState() => _NewTende2ScreenState();
}

class _NewTende2ScreenState extends State<NewTende2Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController tenderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> productNameController = [TextEditingController()];
  List<TextEditingController> quantityController = [TextEditingController()];
  TextEditingController currencyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currencyController = TextEditingController(text: 'шт');
    // unitController = TextEditingController(text: 'шт');
    // dimensionsUnitController = TextEditingController(text: 'см');
    // weightUnitController = TextEditingController(text: 'кг');

    if (widget.isEdit) {
      loadTenderData();
    }
  }

  loadTenderData() async {
    final tenderData =
        context.read<TenderDetailBloc>().state.tenderDetailModel!.data!;
    tenderController.text = tenderData.title ?? '';
    descriptionController.text = tenderData.description ?? '';
    for (int i = 0; i < tenderData.tenderProducts!.length; i++) {
      productNameController[i].text =
          tenderData.tenderProducts![i].productName ?? '';
      quantityController[i].text =
          tenderData.tenderProducts![i].quantity.toString();
      if (i + 1 < tenderData.tenderProducts!.length) {
        addNewProduct();
      }
    }
    phoneController.text = tenderData.phone ?? '';
    emailController.text = tenderData.email ?? '';
    minPriceController.text = tenderData.budgetFrom.toString();
    maxPriceController.text = tenderData.budgetTo.toString();
    context.read<TendersBloc>().add(UpdateTenderImages(tenderData.media!));

    context
        .read<TendersBloc>()
        .add(GetCategoryById(tenderData.tenderCategory!.id.toString()));

    // context
    //     .read<AddTenderBloc>()
    //     .add(UpdateTenderCompany(company: tenderData.company!));

    // setState(() {
    //   context.read<TendersBloc>().state.newTenderModel.selectedCompany =
    //       tenderData.company!;
    // });
    updateCompany(tenderData.company!);
  }

  void updateCompany(CompanyItem company) {
    final companyList = context.read<CompanyBloc>().state.myCompanies;

    CompanyItem? matchedCompany =
        companyList.firstWhereOrNull((c) => c.id == company.id);

    if (matchedCompany != null) {
      setState(() {
        context.read<TendersBloc>().state.newTenderModel.selectedCompany =
            matchedCompany;
      });
    }
  }

  void addNewProduct() {
    setState(() {
      productNameController.add(TextEditingController());
      quantityController.add(TextEditingController());
    });
  }

  void removeProduct(int index) {
    setState(() {
      productNameController[index].dispose();
      productNameController.removeAt(index);

      quantityController[index].dispose();
      quantityController.removeAt(index);
    });
  }

  void saveTender({bool isShowPreview = true}) {
    if (_formKey.currentState!.validate()) {
      final tenderData = context.read<TendersBloc>().state.newTenderModel;
      if (!widget.isEdit &&
          (tenderData.images == null || tenderData.images!.isEmpty)) {
        showShortToast('select_image'.tr);
        return;
      }
      if (widget.isEdit) {
        final addTenderModel = context.read<TendersBloc>().state.newTenderModel;

        if (widget.isEdit &&
            (tenderData.images == null || tenderData.images!.isEmpty) &&
            (addTenderModel.uploadedImages == null ||
                addTenderModel.uploadedImages!.isEmpty)) {
          showShortToast('select_image'.tr);
          return;
        }
      }
      if (tenderData.selectedCompany == null) {
        showShortToast('select_company'.tr);
        return;
      }
      List<TenderProduct> products = [];

      for (int i = 0; i < productNameController.length; i++) {
        String productName = productNameController[i].text;
        int quantity = int.tryParse(quantityController[i].text) ?? 0;

        if (productName.isNotEmpty && quantity > 0) {
          products.add(TenderProduct(
              id: DateTime.now().toString(),
              productName: productName,
              quantity: quantity));
        }
      }

      tenderData.whatToBuy = tenderController.text;
      tenderData.shortDescription = descriptionController.text;
      tenderData.product = products;
      tenderData.budgetStart = minPriceController.text;
      tenderData.budgetEnd = maxPriceController.text;
      tenderData.phone = "${AppConstants.countryCode}${phoneController.text}";
      tenderData.email = emailController.text;

      if (isShowPreview) {
        Get.to(() => NewTenderPreviewScreen(
              isEdit: widget.isEdit,
            ));
      } else {
        if (widget.isEdit) {
          final tenderdata = context.read<TendersBloc>().state.newTenderModel;
          log('this is tender data = ${tenderdata.toJson()}');
          context.read<AddTenderBloc>().add(UpdateTender(
              context.read<TendersBloc>().state.newTenderModel,
              context
                  .read<TenderDetailBloc>()
                  .state
                  .tenderDetailModel!
                  .data!
                  .id!));
        } else {
          final tenderdata = context.read<TendersBloc>().state.newTenderModel;
          log('this is tender data = ${tenderdata.toJson()}');
          context
              .read<AddTenderBloc>()
              .add(AddNewTender(addTenderModel: tenderdata));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create_a_new_tender'.tr),
      ),
      body: BlocListener<AddTenderBloc, AddTenderState>(
        listener: (context, stateListner) async {
          if (stateListner is AddTenderSuccess) {
            // showShortToast('new tended added');
            context.read<PublicTenderBloc>().add(GetPublicTender(1, direction: 'asc'));
            await Get.dialog(CustomDialog(
                widget: AlertDialog(
              title:
                  Text(widget.isEdit ? "tender_updated".tr : 'tender_added'.tr),
              content: Text(widget.isEdit
                  ? 'tender_updated_successfully'.tr
                  : 'tender_added_successfully'.tr),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Ok')),
              ],
            )));
            Get.offAll(() => DashboardScreen());
            context.read<TendersBloc>().add(ResetNewTenderModel());
          }
          if (stateListner is AddTenderError) {
            showShortToast('new tender error');
          }
        },
        child: BlocBuilder<TendersBloc, TendersState>(
          builder: (context, state) {
            return BlocBuilder<TendersBloc, TendersState>(
              builder: (context, tendersState) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'what_do_you_want_to_buy'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              CustomTextField1(
                                controller: tenderController,
                                hintColor: 'without_quotes_for_example_B2B'.tr,
                                inputType: TextInputType.text,
                                lableText: 'without_quotes_for_example_B2B'.tr,
                                leading: '',
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
                                'photo'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'add_a_photo_of_the_product_you_are_looking_for'
                                    .tr,
                                style: body14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.isEdit)
                                if (tendersState
                                            .newTenderModel.uploadedImages !=
                                        null &&
                                    tendersState.newTenderModel.uploadedImages!
                                        .isNotEmpty) ...[
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: tendersState
                                        .newTenderModel.uploadedImages!
                                        .map(
                                          (image) => Stack(
                                            children: [
                                              ClipRRect(
                                                  // height: 80,
                                                  // width: 80,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: CustomImage(
                                                      image: image.url ?? '',
                                                      height: 80,
                                                      width: 80,
                                                      radius: 0)
                                                  // Image.file(
                                                  //   File(image.path),
                                                  //   height: 80,
                                                  //   width: 80,
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                  ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<TendersBloc>()
                                                      .add(RemoveTenderImage(
                                                          image));
                                                },
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                        Images.svgTrash),
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
                              if (state.newTenderModel.images != null &&
                                  state.newTenderModel.images!.isNotEmpty) ...[
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: state.newTenderModel.images!
                                      .map(
                                        (image) => Stack(
                                          children: [
                                            ClipRRect(
                                              // height: 80,
                                              // width: 80,
                                              borderRadius:
                                                  BorderRadius.circular(12),

                                              child: Image.file(
                                                File(image.path),
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<TendersBloc>()
                                                    .add(RemoveGallery(image));
                                              },
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      Images.svgTrash),
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
                                        title: Text('select_image'.tr),
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Get.back();
                                              // reviewController.pickImageDocsCamera();
                                              context
                                                  .read<TendersBloc>()
                                                  .add(PickImageDocsCamera());
                                            },
                                            leading: const Icon(Icons.camera),
                                            title: Text('camera'.tr),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              Get.back();

                                              context
                                                  .read<TendersBloc>()
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                height: 10,
                              ),
                              Text(
                                'short_description'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'specify_what_you_want_to_order_the_volume_of_supplies_deadlines_and_delivery_conditions'
                                    .tr,
                                style: body14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: descriptionController,
                                hintColor: 'description'.tr,
                                inputType: TextInputType.none,
                                leading: '',
                                readOnly: false,
                                maxLines: 4,
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
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: productNameController.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'product_name'.tr,
                                            style: h16.copyWith(
                                                color: ColorResources.darkGray),
                                          ),
                                        ),
                                        if (index != 0)
                                          IconButton(
                                            onPressed: () {
                                              removeProduct(index);
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_sharp,
                                              color: Colors.red,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField1(
                                      controller: productNameController[index],
                                      hintColor: 'product_name',
                                      lableText: 'Например: Стулья',
                                      inputType: TextInputType.text,
                                      leading: '',
                                      readOnly: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'required_field'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: CustomTextField1(
                                            controller:
                                                quantityController[index],
                                            hintColor: '',
                                            inputType: TextInputType.number,
                                            lableText: 'quantity'.tr,
                                            leading: '',
                                            readOnly: false,
                                            validator: (p0) {
                                              if (p0 == null || p0.isEmpty) {
                                                return 'required_field'.tr;
                                              }
                                              return null;
                                            },
                                            lableStyle: h16.copyWith(
                                                color: ColorResources.darkGray),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: CustomTextField1(
                                              controller: currencyController,
                                              hintColor: '',
                                              inputType: TextInputType.none,
                                              lableText: 'Ед.изм',
                                              leading: '',
                                              readOnly: true,
                                              lableStyle: h16.copyWith(
                                                  color:
                                                      ColorResources.darkGray),
                                              validator: (value) {
                                                return null;
                                              },
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButtonWithIcon(
                                onTap: () {
                                  addNewProduct();
                                },
                                buttonColor: ColorResources.lgColor,
                                textColor: ColorResources.black,
                                svgIconColor: ColorResources.black,
                                isMaxSize: false,
                                title: 'add_products'.tr,
                                svgIcon: Images.svgPlus,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'budget'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                        controller: minPriceController,
                                        hintColor: 'от 500 с',
                                        inputType: TextInputType.text,
                                        leading: '',
                                        readOnly: false),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: maxPriceController,
                                      hintColor: 'до 20 000 с',
                                      inputType: TextInputType.text,
                                      leading: '',
                                      readOnly: false,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'phone_number'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              // phone number
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  // height: 64,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: const Color.fromRGBO(
                                          208, 213, 221, 1),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 26,
                                        height: 16,
                                        color: ColorResources.primaryRed,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          Images.svgPhoneFieldLogo,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        Images.arrowForward,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center, // Aligns both text and input in the center
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              child: Text(
                                                AppConstants.countryCode,
                                                style: body16,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: TextFormField(
                                                maxLength: 10,
                                                controller: phoneController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration:
                                                    const InputDecoration(
                                                  counterText: "",
                                                  isDense: true,
                                                  isCollapsed: true,

                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical:
                                                              5), // Adjust vertical padding as needed
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                                style: body16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Text(
                                'email_address'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              // email
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  controller: emailController,
                                  hintColor: '@gmail.com',
                                  inputType: TextInputType.emailAddress,
                                  leading: Images.svgMail,
                                  readOnly: false),

                              const SizedBox(
                                height: 10,
                              ),

                              // select category

                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'select_category'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              GestureDetector(
                                onTap: () {
                                  Get.to(() => SelectCategoryScreen(
                                        isProductCategory: true,
                                        alreadySelected: tendersState
                                                        .newTenderModel
                                                        .categories ==
                                                    null ||
                                                tendersState.newTenderModel
                                                    .categories!.isEmpty
                                            ? []
                                            : tendersState
                                                .newTenderModel.categories,
                                        onSelect: (selectedCategories) {
                                          context.read<TendersBloc>().add(
                                              SelectCategory(
                                                  selectedCategories.first));
                                          Get.back();
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
                                        tendersState.newTenderModel
                                                        .categories ==
                                                    null ||
                                                tendersState.newTenderModel
                                                    .categories!.isEmpty
                                            ? 'select_category'.tr
                                            : tendersState.newTenderModel
                                                    .categories!.first.name ??
                                                '',
                                        style: body16.copyWith(
                                            color: ColorResources.gray),
                                      )),
                                      Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // end category
                              const SizedBox(
                                height: 20,
                              ),

                              Text(
                                'select_company'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
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
                                      value:
                                          state.newTenderModel.selectedCompany,
                                      isExpanded: true,
                                      hint: Text(
                                        state.newTenderModel.selectedCompany
                                                ?.name ??
                                            'select_company'.tr,
                                        style: body16.copyWith(
                                            color: ColorResources.gray),
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
                                                state.newTenderModel
                                                    .selectedCompany = newValue;
                                              });
                                            }
                                          : null,

                                      items: companyState.myCompanies
                                          .map((CompanyItem city) {
                                        return DropdownMenuItem<CompanyItem>(
                                          value: city,
                                          child: Text(city.name ?? '',
                                              style: body16),
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
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: CustomBorderButton(
                padding: const EdgeInsets.all(0),
                border: Border.all(width: 1, color: ColorResources.blue),
                borderRadius: BorderRadius.circular(12),
                boxShaow: const [ColorResources.shadowXS],
                width: Get.width,
                height: Get.height,
                onTap: () {
                  saveTender();
                },
                // Preview
                child: Text(
                  'preview'.tr,
                  style: textMd.copyWith(color: ColorResources.blue),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: BlocBuilder<AddTenderBloc, AddTenderState>(
                  builder: (context, addTenderState) {
                if (addTenderState.isLoading == true) {
                  return CustomButtonLoader(
                      width: Get.width, height: Get.height);
                }
                return CustomButton(
                    width: Get.width,
                    height: Get.height,
                    onTap: () {
                      saveTender(isShowPreview: false);
                    },
                    title: 'save'.tr);
              }),

              // CustomButton(
              //   width: Get.width,
              //   height: Get.height,
              //   onTap: () {
              //     saveTender();
              //   },
              //   // save
              //   title: 'save'.tr,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
