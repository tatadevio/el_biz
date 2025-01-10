import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/widgets/new_message_widget.dart';
import 'package:el_biz/view/screen/contracts/new_contract_screen.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatConversation extends StatelessWidget {
  final bool isSeller;
  final String userId;
  final String receiverId;
  const ChatConversation(
      {super.key,
      required this.isSeller,
      this.userId = 'userId',
      this.receiverId = 'tskJIEBnmogGnMFUreC8mdu9HFu2'});

  // List<ChatList> chatList = [
  //   ChatList(
  //     id: 1,
  //     senderId: Product(id: 1, name: 'name', image: ''),
  //     receiverId: Product(id: 1, name: 'name', image: ''),
  //     type: 'text',
  //     message: 'new message',
  //     image: '',
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //   ),
  //   ChatList(
  //     id: 1,
  //     senderId: Product(id: 1, name: 'name', image: ''),
  //     receiverId: Product(id: 1, name: 'name', image: ''),
  //     type: 'text',
  //     message: 'new message',
  //     image: '',
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () {},
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          leading: CustomImage(image: '', height: 32, width: 32, radius: 5.3),
          title: Text(
            'Садовая мебель Loft',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          subtitle: Text(
            '2 500 сом/шт',
            style: body14.copyWith(color: ColorResources.blue),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Column(
            children: [
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (!isSeller) ...[
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      Expanded(
                        child: CustomBorderButton(
                          height: 36,
                          width: Get.width,
                          padding: const EdgeInsets.all(0),
                          border:
                              Border.all(width: 1, color: ColorResources.blue),
                          borderRadius: BorderRadius.circular(8),
                          boxShaow: const [ColorResources.shadow1],
                          child: Text(
                            'select_products'.tr,
                            style: textSm.copyWith(color: ColorResources.blue),
                          ),
                          onTap: () {
                            Get.to(
                              () => const ProductScreen(isSelectProduct: true),
                            );
                          },
                        ),
                      ),
                      if (isSeller) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Get.to(() => const NewContractScreen());
                            },
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: ColorResources.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorResources.green),
                                boxShadow: const [ColorResources.shadow1],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Images.svgPlus),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'agreement'.tr,
                                    style: textSm.copyWith(
                                        color: ColorResources.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const SizedBox();
                // MessageBubble(chat: chatList[index], addDate: false);
              },
            ),
          ),
          NewMessageWidget(
            userId: userId,
            receiverId: receiverId,
          ),
        ],
      ),
    );
  }
}
