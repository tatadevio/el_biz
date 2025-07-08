import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/view/base/company_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../utils/color_resources.dart';

class NewCompaniesScreen extends StatefulWidget {
  const NewCompaniesScreen({super.key});

  @override
  State<NewCompaniesScreen> createState() => _NewCompaniesScreenState();
}

class _NewCompaniesScreenState extends State<NewCompaniesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<PublicCompanyBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isMoreLoading) {
        int pageSize = accountController.state.newCompanyPageSize;
        if (accountController.state.newCompanyCurrentPage < pageSize) {
          int nextPage = accountController.state.newCompanyCurrentPage;

          accountController.add(GetNewPublicCompany(nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _callScrolling(context, _scrollController);
    return Scaffold(
      appBar: AppBar(
        title: Text('new_companies'.tr),
      ),
      body: Stack(
        children: [
          BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
              builder: (context, companyState) {
            if (companyState.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (companyState.newCompanies.isEmpty) {
              return Center(
                child: Text('no_company_found'.tr),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<PublicCompanyBloc>().add(GetNewPublicCompany(1));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: companyState.publicCompanies.length,
                  itemBuilder: (context, index) {
                    return CompanyItemWidget(
                        company: companyState.publicCompanies[index]);
                  },
                ),
              ),
            );
          }),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primary,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
