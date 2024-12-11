import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      return Column(
        children: [
          CustomTextField(
            controller: searchController,
            hintColor: 'search_in_chats'.tr,
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
                    context.read<ChatBloc>().add(const UpdateShowMySales(showMySales: false));
                    // chatState.updateShowMySales(false);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: !chatState.isShowMySales ? 2 : 1,
                          color: !chatState.isShowMySales ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'my_purchases'.tr,
                      style: textSm.copyWith(color: !chatState.isShowMySales ? ColorResources.blue : ColorResources.gray),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.read<ChatBloc>().add(const UpdateShowMySales(showMySales: true));
                    // chatState.updateShowMySales(true);
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: chatState.isShowMySales ? 2 : 1,
                          color: chatState.isShowMySales ? ColorResources.blue : ColorResources.lgColor,
                        ),
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'my_sales'.tr,
                      style: textSm.copyWith(color: chatState.isShowMySales ? ColorResources.blue : ColorResources.gray),
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
