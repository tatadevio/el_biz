import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/chat_controller.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_textfield.dart';

class ContractTopBar extends StatefulWidget {
  const ContractTopBar({super.key});

  @override
  State<ContractTopBar> createState() => _ContractTopBarState();
}

class _ContractTopBarState extends State<ContractTopBar> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (chatController) {
      return Column(
        children: [
          CustomTextField(
            controller: searchController,
            hintColor: 'Поиск в чатах',
            inputType: TextInputType.text,
            leading: Images.svgSearch,
            readOnly: false,
            suffix: IconButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  searchController.clear();
                }
              },
              icon: const Icon(Icons.close),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    chatController.updateShowMySales(false);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: !chatController.isShowMySales ? 2 : 1,
                          color: !chatController.isShowMySales ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Мои покупки',
                      style: textSm.copyWith(color: !chatController.isShowMySales ? ColorResources.blue : ColorResources.gray),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    chatController.updateShowMySales(true);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: chatController.isShowMySales ? 2 : 1,
                          color: chatController.isShowMySales ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Мои продажи',
                      style: textSm.copyWith(color: chatController.isShowMySales ? ColorResources.blue : ColorResources.gray),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
