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

      final publicCompanyBloc = context.read<PublicCompanyBloc>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !publicCompanyBloc.state.isLoading &&
          !publicCompanyBloc.state.isMoreLoading) {
        int pageSize = publicCompanyBloc.state.newCompanyPageSize;
        if (publicCompanyBloc.state.newCompanyCurrentPage < pageSize) {
          int nextPage = publicCompanyBloc.state.newCompanyCurrentPage;

          publicCompanyBloc.add(GetNewPublicCompany(nextPage + 1));
        }
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

  @override
  Widget build(BuildContext context) {
    // _callScrolling(context, _scrollController);
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
            print(
                'new companies list length in file = ${companyState.newCompanies.length} and ${companyState.newCompanyCurrentPage} and ${companyState.newCompanyPageSize}');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<PublicCompanyBloc>().add(GetNewPublicCompany(1));
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: companyState.newCompanies.length,
                        itemBuilder: (context, index) {
                          return CompanyItemWidget(
                              company: companyState.newCompanies[index]);
                        },
                      ),
                      if (companyState.isMoreLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ).paddingOnly(
                            bottom: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
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
