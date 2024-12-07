import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({super.key});

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: ColorResources.lgColor),
        ),
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: ColorResources.gray,
              )),
          Expanded(
            child: TextFormField(
              readOnly: false,
              controller: textController,
              focusNode: focusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                counterText: "",
                suffixIcon: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {
                    textController.clear();
                    // focusNode.unfocus();
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: textController.text.isEmpty ? ColorResources.lgColor : ColorResources.blue,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(Images.svgSendArrow),
                  ),
                ),
                isDense: true,
                counterStyle: const TextStyle(color: ColorResources.lightGrey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ColorResources.dividerColor)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ColorResources.dividerColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ColorResources.dividerColor)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorResources.primaryRed)),
                hintText: '',
                hintStyle: const TextStyle(color: Color(0xff646F7F)),
              ),
              maxLines: 1,
              onChanged: (value) {
                if (textController.text.isEmpty) {
                  setState(() {});
                } else {
                  if (textController.text.length == 1) {
                    setState(() {});
                  }
                }
              },
            ),

            // CustomTextField(
            //   controller: textController,
            //   hintColor: '',
            //   inputType: TextInputType.text,
            //   leading: '',

            //   readOnly: false,
            // suffix: Container(
            //   height: 23,
            //   width: 23,
            //   decoration: BoxDecoration(
            //     color: textController.text.isEmpty ? ColorResources.lgColor : ColorResources.blue,
            //     shape: BoxShape.circle,
            //   ),
            //   alignment: Alignment.center,
            //   child: SvgPicture.asset(Images.svgSendArrow),
            // ),
            // ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
