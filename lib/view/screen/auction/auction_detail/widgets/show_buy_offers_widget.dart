import 'package:el_biz/bloc/auction/auction_buy_offer/auction_buy_offer_bloc.dart';
import 'package:el_biz/data/model/response/auction/get_buy_offer_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ShowBuyOffersWidget extends StatelessWidget {
  final List<BuyOfferData> offers;
  const ShowBuyOffersWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: Get.height * 0.55,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'accept_the_buy_offer'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(offer.user?.name ?? ''),
                    subtitle: Text(offer.company?.name ?? ''),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6)),
                          backgroundColor:
                              WidgetStatePropertyAll(ColorResources.primary),
                          foregroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      onPressed: () {
                        // Handle accept offer action
                        Get.back();
                        context
                            .read<AuctionBuyOfferBloc>()
                            .add(RespondToBuyOfferEvent(offer.id!));
                      },
                      child: Text('accept'.tr),
                    ),
                  );
                },
              )),
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle view buy offers action
              //   },
              //   child: const Text('View Buy Offers'),
              // ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: SizedBox(
            // height: 40,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    );
  }
}
