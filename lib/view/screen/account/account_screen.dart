import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/account/account_bloc.dart';
import '../../../bloc/company/company_bloc.dart';
import '../../../data/model/response/account/my_accounts_model.dart';
import '../../../data/model/response/bank_model.dart';
import '../company/add_company_document_screen.dart';
import 'widgets/edit_account_info_bottom_sheet.dart';

class AccountScreen extends StatefulWidget {
  final bool isAddNewCompany;
  final bool isEdit;
  const AccountScreen(
      {super.key, this.isAddNewCompany = false, this.isEdit = false});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _selectedOption = '';

  void _callScrolling(ScrollController scrollController) {
    final accountController = context.read<AccountBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.moreLoading) {
        int pageSize = accountController.state.pageSize;
        if (accountController.state.currentPage < pageSize) {
          int nextPage = accountController.state.currentPage;

          accountController.add(GetMyAccounts(currentPage: nextPage + 1));
        }
      }
    });
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    _callScrolling(_controller);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AccountBloc>().add(GetMyAccounts(currentPage: 1));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            print('current page: ${state.currentPage}');
            print('page size: ${state.pageSize}');

            if (state.accountItems.isEmpty) {
              return Center(
                child: Text(
                  'no_account_found'.tr,
                  style: body14.copyWith(color: ColorResources.darkGray),
                ),
              );
            }
            return SingleChildScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'main_invoice_for_payment'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.accountItems
                                  .any((account) => account.primaryAccount == 1)
                              ? state.accountItems
                                      .firstWhere((account) =>
                                          account.primaryAccount == 1)
                                      .accountName ??
                                  ''
                              : '',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          state.accountItems
                                  .any((account) => account.primaryAccount == 1)
                              ? state.accountItems
                                      .firstWhere((account) =>
                                          account.primaryAccount == 1)
                                      .accountNumber ??
                                  ''
                              : '',
                          style: body16.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state.accountItems.isNotEmpty)
                    Text(
                      'all_account'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.accountItems.length,
                      itemBuilder: (context, index) {
                        return accoutItem(state.accountItems[index]);
                      }),

                  // ListView(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   children: [
                  //     accoutItem('Optima USD', '0202020202002'),
                  //     accoutItem('Optima KGS', '0202020202002'),
                  //   ],
                  // ),
                  if (state.moreLoading)
                    const Center(child: CircularProgressIndicator())
                        .paddingOnly(bottom: 150),
                  // else
                  //   const SizedBox.shrink(),
                ],
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child:
            BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
          // Determine button properties based on conditions
          bool hasAccounts = state.accountItems.isNotEmpty;

          // Check if there's a selection: either _selectedOption is set OR there's a primary account
          bool hasPrimaryAccount =
              state.accountItems.any((account) => account.primaryAccount == 1);
          bool hasSelection = _selectedOption.isNotEmpty || hasPrimaryAccount;

          bool isButtonActive = true;
          String buttonText = 'add_account'.tr;
          Color buttonColor = ColorResources.primary;
          Color textColor = Colors.white;

          if (widget.isAddNewCompany) {
            if (hasAccounts) {
              // If there are accounts, button should be "continue" and require selection
              buttonText = widget.isEdit ? 'add_account'.tr : 'continue'.tr;
              isButtonActive =
                  hasSelection; // Active if account is selected OR there's a primary account
              if (!isButtonActive) {
                buttonColor = ColorResources.gray;
                textColor = ColorResources.darkGray;
              }
            } else {
              // If no accounts, button should be "add_account"
              buttonText = 'add_account'.tr;
              isButtonActive = true;
            }
          } else {
            // Normal case - always show add_account
            buttonText = 'add_account'.tr;
            isButtonActive = true;
          }

          return CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
                if (!isButtonActive) {
                  // Button is disabled, do nothing but could show a toast
                  if (widget.isAddNewCompany && hasAccounts && !hasSelection) {
                    showShortToast('select_account'.tr);
                  }
                  return;
                }

                if (widget.isAddNewCompany) {
                  if (hasAccounts && !hasSelection) {
                    showShortToast('select_account'.tr);
                    return;
                  }

                  if (hasAccounts) {
                    // Navigate to next screen with selected account
                    final accountState = context.read<AccountBloc>().state;
                    List<BankItem> allBanks = [];

                    // Find the selected account (either from _selectedOption or primary account)
                    String selectedAccountNumber = _selectedOption.isNotEmpty
                        ? _selectedOption
                        : accountState.accountItems
                                .firstWhere(
                                    (account) => account.primaryAccount == 1)
                                .accountNumber ??
                            '';

                    for (int i = 0; i < accountState.accountItems.length; i++) {
                      if (accountState.accountItems[i].accountNumber ==
                          selectedAccountNumber) {
                        String accountName =
                            accountState.accountItems[i].accountName ?? '';
                        String accountNumber =
                            accountState.accountItems[i].accountNumber ?? '';
                        String bik = accountState.accountItems[i].bic ?? '';
                        allBanks.add(
                          BankItem(
                            id: DateTime.now().millisecondsSinceEpoch + i,
                            bankName: bik,
                            accountName: accountName,
                            accountNumber: accountNumber,
                            image: '',
                          ),
                        );
                        break; // Found the account, no need to continue
                      }
                    }

                    final companyModel =
                        context.read<CompanyBloc>().state.addCompanyModel;
                    companyModel.bankData = allBanks;
                    Get.to(() => AddCompanyDocumentScreen(
                          isEdit: widget.isEdit,
                        ));
                  } else {
                    // No accounts, show add account bottom sheet
                    Get.bottomSheet(
                        const EditAccountInfoBottomSheet(
                          isAddNew: true,
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: true);
                  }
                } else {
                  // Normal add account behavior
                  Get.bottomSheet(
                      const EditAccountInfoBottomSheet(
                        isAddNew: true,
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true);
                }
              },
              title: buttonText,
              color: buttonColor,
              textColor: textColor,
              radius: 10);
        }),
      ),
    );
  }

  Widget accoutItem(AccountItem account) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            RadioListTile<String>(
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.accountName ?? '',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(33, 32, 32, 1)),
                  ),
                  Text(
                    account.accountNumber ?? '',
                    style: body16.copyWith(color: ColorResources.gray),
                  ),
                ],
              ),
              value: account.accountNumber ?? '',
              groupValue: account.primaryAccount == 1
                  ? account.accountNumber
                  : _selectedOption,
              onChanged: (value) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('confirm'.tr),
                      content: Text(
                          'are_you_sure_to_add_this_account_as_primary_account?'.tr),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: Text('cancel'.tr),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ColorResources.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: Text('yes'.tr),
                          onPressed: () {
                            print('Selected Account ID: ${account.id}');
                            context.read<AccountBloc>().add(MakePrimaryAccount(
                                  id: account.id ?? 0,
                                ));
                            setState(() {
                              _selectedOption = value!;
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                        EditAccountInfoBottomSheet(
                          isAddNew: false,
                          account: account,
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: true);
                  },
                  child: Text(
                    'edit'.tr,
                    style: button16.copyWith(color: ColorResources.blue),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Optima USD',
        //       style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w400),
        //     ),
        //     Text(
        //       '0202020202002',
        //       style: body16.copyWith(color: ColorResources.gray),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
