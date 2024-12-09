import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_documents_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_info_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_items.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_tenders.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/my_reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyDataWidget extends StatefulWidget {
  const CompanyDataWidget({super.key});

  @override
  State<CompanyDataWidget> createState() => _CompanyDataWidgetState();
}

class _CompanyDataWidgetState extends State<CompanyDataWidget> with TickerProviderStateMixin {
  // late TabController tabController;
  // double containerHeight = 200;
  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(length: 5, vsync: this);
  //   tabController.addListener(() {
  //     if (tabController.index == 0) {
  //       setState(() {
  //         containerHeight = 200;
  //       });
  //     } else if (tabController.index == 1) {
  //       setState(() {
  //         containerHeight = 300;
  //       });
  //     } else if (tabController.index == 2) {
  //       setState(() {
  //         containerHeight = 400;
  //       });
  //     } else if (tabController.index == 3) {
  //       setState(() {
  //         containerHeight = 500;
  //       });
  //     } else {
  //       setState(() {
  //         containerHeight = 650;
  //       });
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   tabController.dispose();
  //   super.dispose();
  // }

  final List<String> headingItems = [
    'О компании',
    'Товары',
    'tenders'.tr,
    'Отзывы',
    'Документы',
  ];
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: headingItems.length,
                  itemBuilder: (context, index) {
                    return headingTiles(
                      headingItems[index],
                      selectedOption == index,
                      index,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: const Divider(
                  height: 0,
                ),
              ),
            ],
          ),
          if (selectedOption == 0) const CompanyInfoWidget(),
          if (selectedOption == 1) const CompanyItems(),
          if (selectedOption == 2) const CompanyTenders(),
          if (selectedOption == 3) const MyReviewsWidget(),
          if (selectedOption == 4) const CompanyDocumentsWidget(),

          // ButtonsTabBar(
          //   controller: tabController,
          //   backgroundColor: ColorResources.primary,
          //   borderWidth: 0,
          //   contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          //   // borderColor: Colors.black,
          //   labelStyle: const TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   unselectedLabelStyle: const TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   tabs: const [
          //     Tab(text: 'О компании'),
          //     Tab(text: 'Товары'),
          //     Tab(text: 'tenders'),
          //     Tab(text: 'Отзывы'),
          //     Tab(text: 'Документы'),
          //   ],
          // ),
          // const SizedBox(height: 16), // Space between tabs and content
          // Container(
          //   height: containerHeight,
          //   child: TabBarView(
          //     controller: tabController,
          //     physics: const NeverScrollableScrollPhysics(),
          //     children: const [
          //       CompanyInfoWidget(),
          //       Center(child: Text('Content for Tab 2')),
          //       Center(child: Text('Content for Tab 3')),
          //       Center(child: Text('Content for Tab 4')),
          //       MyReviewsWidget(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget headingTiles(String title, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          setState(() {
            selectedOption = index;
          });
        },
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? ColorResources.blue.withOpacity(0.5) : null,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected ? const [ColorResources.shadow1, ColorResources.shadow2] : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: button16.copyWith(color: isSelected ? ColorResources.white : ColorResources.gray),
          ),
        ),
      ),
    );
  }
}
