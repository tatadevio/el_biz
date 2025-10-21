
import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/data/model/response/notification/notifications_model.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/company_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/product_detail/product_detail_bloc.dart';
import '../../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../../bloc/similar_tenders/similar_tenders_bloc.dart';
import '../../../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../contracts/contract_page_screen.dart';
import '../../product_detail/product_detail_screen.dart';
import '../../tender/tender_detail_screen.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem notification;
  final int index;

  const NotificationItemWidget(
      {super.key, required this.notification, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // String token = sharedPreferences.getString(AppConstants.token) ?? "";
        // log('Token: $token');
        if (notification.isRead == false) {
          context
              .read<NotificationBloc>()
              .add(ReadNotification(notification.id.toString()));
        }

        print('notification.type: ${notification.type}');

        // now check the notificaiton type and open
        if (notification.type == 'company') {
          context.read<CompanyDetailBloc>().add(
              GetCompanyDetail(notification.data?.companyId.toString() ?? ''));
                  context.read<SimilarCompaniesBloc>().add(GetSimilarCompanies(
              companyId: notification.data?.companyId.toString() ?? '', currentPage: 1));
          Get.to(() => CompanyPageScreen(
                isCompany: true,
              ));
        } else if (notification.type == 'product') {
          context.read<ProductDetailBloc>().add(
              GetProductDetail(notification.data?.productId.toString() ?? ''));
          Get.to(() => ProductDetailScreen(isProduct: true));
        } else if (notification.type == 'tender') {
          context.read<TenderDetailBloc>().add(GetTenderDetail(
              tenderId: notification.data?.tenderId.toString() ?? ''));
          context.read<SimilarTendersBloc>().add(GetSimilarTenders(
              tenderId: notification.data?.tenderId.toString() ?? '',
              currentPage: 1));
          Get.to(() => TenderDetailScreen(
              tenderName: notification.data?.tenderTitle.toString() ?? ''));
        } else if (notification.type == 'contract_creation' ||
            notification.type == 'contract_signing' ||
            notification.type == "payment" ||
            notification.type == "contract_status") {
          context.read<ContractsBloc>().add(GetContractDetail(
              contractId: notification.data?.contractId.toString() ?? ''));
          Get.to(() => ContractPageScreen(
              contractId: notification.data?.contractId ?? 0));
        }

        // const TYPE_CONTRACT_STATUS = 'contract_status';
        // const TYPE_CONTRACT_SIGNING = 'contract_signing';
        // const TYPE_CONTRACT_CREATION = 'contract_creation';
        // const TYPE_PRODUCT = 'product';
        // const TYPE_TENDER = 'tender';
        // const TYPE_PAYMENT = 'payment';
        // const TYPE_REVIEW = 'review';
        // const TYPE_CHAT = 'chat';
        // const TYPE_SYSTEM = 'system';
        // const TYPE_COMPANY = 'company';
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: notification.isRead == false ? Colors.white12 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Color.fromRGBO(16, 24, 40, 0.1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      // index % 2 == 0
                      notification.type == 'payment'
                          ? ColorResources.blue
                          : ColorResources.green,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  // index % 2 == 0 ? Images.svgWallet : Images.svgShoppingBag,
                  notification.type == 'payment'
                      ? Images.svgWallet
                      : Images.svgShoppingBag,
                  height: 16,
                  width: 16,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title ?? '',
                            // 'Вам был отправлен документ от компании ст',
                            style: h16.copyWith(color: ColorResources.darkGray),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          formatDateInRu(notification.createdAt.toString()),
                          // '12 сен. 2024',
                          style: body12.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      notification.body ?? '',
                      // 'Садовая мебель Loft добавил вашу закупку',
                      style: body14.copyWith(color: ColorResources.gray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
