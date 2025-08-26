import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_documents_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_info_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_items.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/company_tenders.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/my_reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'company_data.dart/company_auctions.dart';

class CompanyDataWidget extends StatefulWidget {
  final ScrollController scrollController;
  const CompanyDataWidget({super.key, required this.scrollController});

  @override
  State<CompanyDataWidget> createState() => _CompanyDataWidgetState();
}

class _CompanyDataWidgetState extends State<CompanyDataWidget>
    with TickerProviderStateMixin {
  final List<String> headingItems = [
    "about_company",
    'goods',
    'tenders',
    'auctions',
    'reviews',
    'documents',
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
                      headingItems[index].tr,
                      selectedOption == index,
                      index,
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  height: 0,
                ),
              ),
            ],
          ),
          if (selectedOption == 0) const CompanyInfoWidget(),
          if (selectedOption == 1)
            CompanyItems(
              scrollController: widget.scrollController,
            ),
          if (selectedOption == 2)
            CompanyTenders(
              scrollController: widget.scrollController,
            ),
          if (selectedOption == 3)
            CompanyAuctions(
              scrollController: widget.scrollController,
            ),
          if (selectedOption == 4) const MyReviewsWidget(),
          if (selectedOption == 5) const CompanyDocumentsWidget(),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? ColorResources.blue.withOpacity(0.5) : null,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? const [ColorResources.shadow1, ColorResources.shadow2]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: button16.copyWith(
                color: isSelected ? ColorResources.white : ColorResources.gray),
          ),
        ),
      ),
    );
  }
}
