import 'dart:developer';

import 'package:el_biz/bloc/product_import/product_import_bloc.dart';
import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/product_import/product_import_event.dart';
import '../../../bloc/product_import/product_import_state.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../data/model/response/company/my_companies_model.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_button.dart';
import '../category/select_category_screen.dart';
import 'widgets/import_porducts_status_widget.dart';
import 'widgets/save_excel_file.dart';

class ImportProductScreen extends StatefulWidget {
  const ImportProductScreen({super.key});

  @override
  State<ImportProductScreen> createState() => _ImportProductScreenState();
}

class _ImportProductScreenState extends State<ImportProductScreen> {
  CategoryItem? selectedCategory;
  CompanyItem? selectedCompany;
  FilePickerResult? selectedFile;

  @override
  void initState() {
    super.initState();
    updateSelectedCompany();
  }

  updateSelectedCompany() {
    if (context.read<UserBloc>().state.selectedAccountModel!.isUser == false) {
      int companyId =
          context.read<UserBloc>().state.selectedAccountModel!.companyId;
      final companyList = context.read<CompanyBloc>().state.myCompanies;

      CompanyItem? matchedCompany =
          companyList.firstWhereOrNull((c) => c.id == companyId);

      if (matchedCompany != null) {
        setState(() {
          selectedCompany = matchedCompany;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import Products'),
      ),
      body: BlocListener<ProductImportBloc, ProductImportState>(
        listener: (context, state) async {
          if (state is ProductImportSuccess) {
            final url = state.response.body[
                'filepath']; // example: https://admin.elbiz.kg/product_import_template.xlsx

            final savedPath = await downloadExcelFile(
              url,
              "product_import_template.xlsx",
            );

            showShortToast("File saved at: $savedPath");
            log(savedPath);
          }
          if (state is AddImportProductsError) {
            showShortToast(state.error);
          }
          if (state is AddImportProductsSuccess) {
            // Get.back();
            // Get.offAll(() => DashboardScreen());
            Get.dialog(ImportPorductsStatusWidget());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'if you don\'t have the Excel farmat that will be accepted to add new products \nyou can download from here'),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(ColorResources.primary),
                    ),
                    onPressed: () {
                      print('download the import file...');
                      context
                          .read<ProductImportBloc>()
                          .add(ProductImportRequested());
                    },
                    label: Text('Download Template'),
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'selected_file'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  Expanded(
                    child: Text(
                      selectedFile?.files.first.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body16.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(ColorResources.primary),
                    ),
                    onPressed: () async {
                      print('select the import file...');

                      final result =
                          await pickExcelOrCsvFile(); // async work outside setState

                      setState(() {
                        selectedFile = result; // synchronous update
                      });
                    },
                    child: Text('Add Products File'),
                    // icon: Icon(
                    //   Icons.download,
                    //   color: Colors.white,
                    // ),
                  ),
                ],
              ),
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
                            selectedCategory == null ? [] : [selectedCategory!],
                        onSelect: (selectedCategories) {
                          setState(() {
                            selectedCategory = selectedCategories.first;
                          });
                          Get.back();
                        },
                      ));
                },
                child: Container(
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                        selectedCategory == null
                            ? 'select_category'.tr
                            : selectedCategory?.name ?? '',
                        style: body16.copyWith(color: ColorResources.gray),
                      )),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
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
                      value: selectedCompany,
                      isExpanded: true,
                      hint: Text(
                        selectedCompany?.name ?? 'select_company'.tr,
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                      underline: const SizedBox(), // Remove default underline
                      onChanged: context
                                  .read<UserBloc>()
                                  .state
                                  .selectedAccountModel!
                                  .isUser ==
                              true
                          ? (CompanyItem? newValue) {
                              setState(() {
                                selectedCompany = newValue;
                              });
                            }
                          : null,
                      items: companyState.myCompanies.map((CompanyItem city) {
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: BlocBuilder<ProductImportBloc, ProductImportState>(
          builder: (context, state) {
            if (state is ProductImportLoading) {
              return CustomButtonLoader(width: Get.width, height: Get.height);
            }
            return CustomButton(
                width: Get.width,
                height: Get.height,
                onTap: () {
                  if (selectedFile == null) {
                    showShortToast('select_products_list');
                    return;
                  } else if (selectedCategory == null) {
                    showShortToast('select_category'.tr);
                    return;
                  } else if (selectedCompany == null) {
                    showShortToast('select_company'.tr);
                    return;
                  }
                  // here call the api to send this data to backend
                  print('ready to send this data to api ....');

                  // context.read<AddProductBloc>().add(AddExcelData());
                  context.read<ProductImportBloc>().add(
                        AddImportProducts(
                          file: selectedFile!,
                          categoryId: selectedCategory!.id.toString(),
                          companyId: selectedCompany!.id.toString(),
                        ),
                      );
                },
                title: 'send'.tr);
          },
        ),
      ),
    );
  }
}
