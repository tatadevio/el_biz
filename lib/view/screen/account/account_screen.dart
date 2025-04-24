import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/account/account_bloc.dart';
import '../../../data/model/response/account/my_accounts_model.dart';
import 'widgets/edit_account_info_bottom_sheet.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _selectedOption = 'Optima USD';

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
                        const Text(
                          'Optima USD',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '0202020202002',
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
                      'all_accounts'.tr,
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
        child: CustomButton(
            width: Get.width,
            height: Get.height,
            onTap: () {
              Get.bottomSheet(
                  const EditAccountInfoBottomSheet(
                    isAddNew: true,
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: true);
            },
            title: 'add_account'.tr,
            color: ColorResources.primary,
            textColor: Colors.white,
            radius: 10),
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
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
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
