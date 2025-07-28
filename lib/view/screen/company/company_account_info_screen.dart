import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/add_company_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../bloc/account/account_bloc.dart';
import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../data/model/response/bank_model.dart';
import '../../../utils/color_resources.dart';
import '../account/account_screen.dart';
import 'widgets/custom_add_company_appbar.dart';

class CompanyAccountInfoScreen extends StatefulWidget {
  final bool isEdit;
  const CompanyAccountInfoScreen({super.key, required this.isEdit});

  @override
  State<CompanyAccountInfoScreen> createState() =>
      _CompanyAccountInfoScreenState();
}

class _CompanyAccountInfoScreenState extends State<CompanyAccountInfoScreen> {
  List<TextEditingController> accountNameControllers = [
    TextEditingController()
  ];
  List<TextEditingController> bikControllers = [TextEditingController()];
  List<TextEditingController> accountNumberControllers = [
    TextEditingController()
  ];

  bool _hasPrimaryAccountLoaded = false;

  void addNewAccount() {
    accountNameControllers.add(TextEditingController());
    bikControllers.add(TextEditingController());
    accountNumberControllers.add(TextEditingController());
    updateUI(); // Call setState or update method here
  }

  void removeAccount(int index) {
    accountNameControllers.removeAt(index);
    bikControllers.removeAt(index);
    accountNumberControllers.removeAt(index);
    updateUI(); // Call setState or update method here
  }

  updateUI() {
    setState(() {});
  }

  void _submitForm() {
    List<BankItem> allBanks = [];
    for (int i = 0; i < accountNameControllers.length; i++) {
      String accountName = accountNameControllers[i].text;
      String accountNumber = accountNumberControllers[i].text;
      String bik = bikControllers[i].text;
      allBanks.add(
        BankItem(
          id: DateTime.now().millisecondsSinceEpoch + i,
          bankName: bik,
          accountName: accountName,
          accountNumber: accountNumber,
          image: '',
        ),
      );
    }
    final companyModel = context.read<CompanyBloc>().state.addCompanyModel;

    companyModel.bankData = allBanks;

    // still no option to select main account
    // Get.bottomSheet(
    //   backgroundColor: Colors.white,
    //   SelectCurrencyWidget(
    //     isEdit: widget.isEdit,
    //   ),
    // );
    // hide bottom sheet to select the main account
    Get.to(() => AddCompanyDocumentScreen(
          isEdit: widget.isEdit,
        ));
  }

  @override
  void initState() {
    super.initState();
    // Load accounts first to check for primary account
    context.read<AccountBloc>().add(GetMyAccounts(currentPage: 1));

    if (widget.isEdit) {
      loadData();
    } else {
      // For new company, check if there's a primary account to pre-fill
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndLoadPrimaryAccount();
      });
    }
  }

  void _checkAndLoadPrimaryAccount() {
    if (_hasPrimaryAccountLoaded) return; // Prevent multiple calls

    final accountState = context.read<AccountBloc>().state;

    // Check if there's a primary account
    final primaryAccounts = accountState.accountItems
        .where((account) => account.primaryAccount == 1)
        .toList();

    if (primaryAccounts.isNotEmpty) {
      final primaryAccount = primaryAccounts.first;
      // Pre-fill with primary account data
      setState(() {
        accountNameControllers[0].text = primaryAccount.accountName ?? '';
        bikControllers[0].text = primaryAccount.bic ?? '';
        accountNumberControllers[0].text = primaryAccount.accountNumber ?? '';
        _hasPrimaryAccountLoaded = true;
      });
    }
    // If no primary account exists, fields remain empty for manual entry
  }

  void _refreshAccountsOnReturn() {
    // Refresh accounts and reload primary account when returning from AccountScreen
    context.read<AccountBloc>().add(GetMyAccounts(currentPage: 1));
    _hasPrimaryAccountLoaded = false; // Reset flag to allow reloading
  }

  void loadData() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;
    //     final companyDocument = context.read<CompanyDetailBloc>().state.companyDocuments!;
    //     // if(companyDocument.)
    print('this is the company account = ${companyData.accounts}');
    for (int i = 0; i < companyData.accounts!.length; i++) {
      accountNameControllers[i].text =
          companyData.accounts?[i].accountName ?? '';
      accountNumberControllers[i].text =
          companyData.accounts?[i].accountNumber ?? '';
      bikControllers[i].text = companyData.accounts?[i].bic ?? '';
      int valid = i;
      if (++valid < companyData.accounts!.length) {
        addNewAccount();
      }
    }
  }

  // void loadData() {
  //   // final companyData =
  //   //     context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;

  //   // emailController.text = companyData.email ?? '';
  //   // if (companyData.phoneNumbers != null &&
  //   //     companyData.phoneNumbers!.isNotEmpty) {
  //   //   for (int i = 0; i < companyData.phoneNumbers!.length; i++) {
  //   //     phoneControllers[i].text =
  //   //         companyData.phoneNumbers![i].startsWith('+996')
  //   //             ? companyData.phoneNumbers![i].replaceFirst('+996', '')
  //   //             : companyData.phoneNumbers![i];
  //   //     // phoneControllers[i].text = companyData.phoneNumbers![i];
  //   //     int valid = i;
  //   //     if (++valid < companyData.phoneNumbers!.length) {
  //   //       addNewPhoneNumber();
  //   //     }
  //   //   }
  //   // }

  //   // if (companyData.contacts != null && companyData.contacts!.isNotEmpty) {
  //   //   for (int i = 0; i < companyData.contacts!.length; i++) {
  //   //     accountNameControllers[i].text = companyData.contacts![i].name ?? '';
  //   //     accountControllers[i].text = companyData.contacts![i].contact ?? '';
  //   //     int valid = i;
  //   //     if (++valid < companyData.contacts!.length) {
  //   //       addNewAccount();
  //   //     }
  //   //   }
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        // When accounts are loaded and this is not an edit screen, check for primary account
        if (!widget.isEdit &&
            state.accountItems.isNotEmpty &&
            !state.isLoading &&
            !_hasPrimaryAccountLoaded) {
          _checkAndLoadPrimaryAccount();
        }
      },
      child: Scaffold(
        appBar: customAddCompanyAppbar(title: ''),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "details".tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Get.to(() => AccountScreen(
                              isAddNewCompany: true,
                              isEdit: widget.isEdit,
                            ));
                        // Refresh accounts when returning from AccountScreen
                        _refreshAccountsOnReturn();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'view_banks'.tr,
                            style:
                                button16.copyWith(color: ColorResources.blue),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(Images.svgArrowForwardIcon),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_hasPrimaryAccountLoaded && !widget.isEdit)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'primary_account_prefilled'.tr,
                      style: body12.copyWith(color: ColorResources.gray),
                    ),
                  ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: accountNameControllers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${'account_no'.tr} ${index + 1}",
                                  style: h16.copyWith(
                                      color: ColorResources.darkGray),
                                ),
                              ),
                              if (index > 0)
                                IconButton(
                                  onPressed: () {
                                    removeAccount(index);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField1(
                              controller: accountNameControllers[index],
                              hintColor: '',
                              inputType: TextInputType.name,
                              lableText: 'give_a_name_for_your_account'.tr,
                              leading: '',
                              readOnly: false),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField1(
                              controller: bikControllers[index],
                              hintColor: '',
                              inputType: TextInputType.text,
                              lableText: 'БИК',
                              leading: '',
                              readOnly: false),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField1(
                              controller: accountNumberControllers[index],
                              hintColor: '',
                              inputType: TextInputType.number,
                              lableText: 'account_number'.tr,
                              leading: '',
                              readOnly: false),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomButtonWithIcon(
                  onTap: addNewAccount,
                  title: 'add_props'.tr,
                  svgIcon: Images.svgPlus,
                  isMaxSize: false,
                  textColor: ColorResources.gray,
                  buttonColor: ColorResources.lgColor,
                  borderColor: ColorResources.lgColor,
                  svgIconColor: ColorResources.gray,
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
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => AddCompanyDocumentScreen(
                            isEdit: widget.isEdit,
                          ));
                    },
                    child: Container(
                      // height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorResources.primary,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 1),
                            color: Color.fromRGBO(16, 24, 40, 0.05),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'skip'.tr,
                        style: textMd.copyWith(color: ColorResources.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _submitForm();
                    },
                    child: Container(
                      // height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorResources.primary,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: ColorResources.primary,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 1),
                            color: Color.fromRGBO(16, 24, 40, 0.05),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'continue'.tr,
                        style: textMd.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Map<String, List<String>> convertContactsToMap(List<List<String>> contacts) {
//   Map<String, List<String>> contactMap = {};

//   // Populate the contactMap with the contact details
//   if (contacts.isNotEmpty) {
//     contactMap['whatsapp'] = contacts[0]; // Assuming first list is WhatsApp
//     contactMap['telegram'] = contacts[1]; // Assuming second list is Telegram
//     contactMap['instagram'] = contacts[2]; // Assuming third list is Instagram
//     contactMap['vk'] = contacts[3]; // Assuming fourth list is VK
//     contactMap['email'] = contacts[4]; // Assuming fifth list is Email
//     contactMap['website'] = contacts[5]; // Assuming sixth list is Website
//   }

//   return contactMap;
// }

// Map<String, String> convertContactsToMapString(
//     Map<String, List<String>> contactMap) {
//   Map<String, String> mapString = {};

//   contactMap.forEach((key, value) {
//     // Join the list items into a single string with comma separator
//     mapString[key] = value.join(', ');
//   });

//   return mapString;
// }

// String convertScheduleToString(List<dynamic> scheduleTiming) {
//   // Convert each schedule to JSON format
//   List<String> schedules =
//       scheduleTiming.map((schedule) => jsonEncode(schedule.toJson())).toList();

//   // Join JSON strings with a delimiter (e.g., newline or comma)
//   return schedules.join(', ');
// }
