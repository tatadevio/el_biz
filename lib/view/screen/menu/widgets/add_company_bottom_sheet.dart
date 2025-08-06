import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/data/model/response/userinfo_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/my_companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../base/custom_toast.dart';

class AddCompanyBottomSheet extends StatefulWidget {
  const AddCompanyBottomSheet({super.key});

  @override
  State<AddCompanyBottomSheet> createState() => _AddCompanyBottomSheetState();
}

class _AddCompanyBottomSheetState extends State<AddCompanyBottomSheet> {
  String? _selectedOption;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    updateSelectedOption();
    // Load my companies when bottom sheet is opened (only if user is logged in)
    if (context.read<AuthBloc>().state.isLoggedIn) {
      context.read<CompanyBloc>().add(GetMyCompanies(currentPage: 1));
    }
  }

  updateSelectedOption() async {
    final userData = context.read<UserBloc>().state.selectedAccountModel;
    if (userData?.isUser == true) {
      _selectedOption = 'user';
    } else {
      _selectedOption = userData!.companyId.toString();
    }
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.myCompanyLoadMore) {
        int pageSize = accountController.state.myCompanyPageSize;
        if (accountController.state.myCompanyCurrentPage < pageSize) {
          int nextPage = accountController.state.myCompanyCurrentPage;

          accountController.add(GetMyCompanies(currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    _callScrolling(context, _scrollController);
    return Container(
      height: height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(color: Colors.white),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, companyState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 3,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'personal_profile'.tr,
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                          ),
                          RadioListTile<String>(
                            contentPadding: const EdgeInsets.all(0),
                            title: accountInfo(
                                title: userState.userInfo?.data?.name ?? '',
                                subTitle:
                                    userState.userInfo?.data?.userRole ?? '',
                                image: userState.userInfo?.data?.image ?? ''
                                // 'Имя Фамилия',
                                // 'ОсОО...',
                                ),
                            value: 'user',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                              context.read<UserBloc>().add(
                                  SwitchSelectedAccount(
                                      profile: userState.userInfo!.data!,
                                      companyItem: CompanyItem(),
                                      isUser: true));
                              // Get.back();
                              // Get.to(() => const CompanyPageScreen());
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (companyState.myCompanies.isNotEmpty)
                            Text(
                              'my_companies'.tr,
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                          if (companyState.myCompanies.isNotEmpty)
                            const SizedBox(
                              height: 10,
                            ),
                          if (companyState.myCompanies.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: companyState.myCompanies.length,
                              itemBuilder: (context, index) {
                                final company = companyState.myCompanies[index];
                                return RadioListTile<String>(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: accountInfo(
                                    title: company.name ?? '',
                                    subTitle: company.tinNumber ?? '',
                                    image: company.logo,
                                    // 'Садовая мебель Loft',
                                    // 'ОсОО...',
                                  ),
                                  value: company.id.toString(),
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });

                                    context.read<UserBloc>().add(
                                        SwitchSelectedAccount(
                                            profile: UserData(),
                                            companyItem: company,
                                            isUser: false));
                                  },
                                );
                              },
                            ),
                          if (companyState.myCompanyLoadMore)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          // RadioListTile<String>(
                          //   contentPadding: const EdgeInsets.all(0),
                          //   title: accountInfo('Посуда Loft', 'ОсОО...'),
                          //   value: 'company2',
                          //   groupValue: _selectedOption,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _selectedOption = value;
                          //     });
                          //   },
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          // addNewCompanyButton(),
                          CustomButtonWithIcon(
                            title: 'add_a_company'.tr,
                            svgIcon: Images.svgPlus,
                            borderColor: ColorResources.green,
                            onTap: () {
                              if (!context.read<AuthBloc>().state.isLoggedIn) {
                                showShortToast('login_first_to_add_company'.tr);
                                Get.back();
                                return;
                              }
                              Get.back();
                              Get.to(() => const MyCompaniesScreen());
                            },
                          ),
                          // CustomButton(width: Get.width, height: 44, onTap: () {}, title: 'Добавить компанию'),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget accountInfo({String? title, String? subTitle, String? image}) {
    return Container(
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResources.lightBlue,
        border: Border.all(width: 1, color: ColorResources.lgColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
            color: Color.fromRGBO(16, 24, 40, 0.1),
          ),
        ],
      ),
      child: ListTile(
        dense: true,
        leading:
            CustomImage(image: image ?? '', height: 40, width: 40, radius: 40),
        title: Text(
          title ?? '',
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
        subtitle: Text(
          subTitle ?? '',
          style: body14.copyWith(color: ColorResources.darkGray),
        ),
      ),
    );
  }

  // Widget addNewCompanyButton() {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(12),
  //     onTap: () {
  //       Get.to(() => MyCompaniesScreen());
  //     },
  //     child: Container(
  //       height: 48,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(
  //           width: 1,
  //           color: ColorResources.green,
  //         ),
  //         color: ColorResources.green,
  //         boxShadow: const [
  //           BoxShadow(
  //             blurRadius: 2,
  //             spreadRadius: 0,
  //             offset: Offset(0, 1),
  //             color: Color.fromRGBO(16, 24, 40, 0.05),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SvgPicture.asset(Images.svgPlus),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Text(
  //             'Добавить компанию',
  //             style: button16,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
