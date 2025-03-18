import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/color_resources.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintColor;
  final String leading;
  final TextInputType inputType;
  // final Color color;
  final bool readOnly;
  final bool validate;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffix;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintColor,
    required this.inputType,
    required this.leading,
    // required this.color,
    required this.readOnly,
    this.maxLength,
    this.validate = false,
    this.maxLines,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.height * 0.06,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          keyboardType: inputType,
          maxLength: maxLength,
          validator: validator ??
              (v) {
                if (validate) {
                  if (maxLength == 9) {
                    if (v!.length < 8) {
                      return "phone_number_valid_toast".tr;
                    }
                  }
                  if (v!.isEmpty) {
                    return "";
                  }
                }
                return null;
              },
          inputFormatters: maxLength == 9
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: leading != ""
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: leading.contains('.svg')
                        ? SvgPicture.asset(leading)
                        : Image.asset(leading),
                  )
                : null,
            suffixIcon: suffix,
            isDense: true,
            counterStyle: const TextStyle(color: ColorResources.lightGrey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: ColorResources.dividerColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: ColorResources.dividerColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: ColorResources.dividerColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: ColorResources.primaryRed)),
            hintText: hintColor,
            hintStyle: const TextStyle(color: Color(0xff646F7F)),
          ),
          maxLines: maxLines,
        ),
      ),
    );
  }
}

class CustomTextField1 extends StatefulWidget {
  final TextEditingController controller;
  final String hintColor;
  final String leading;
  final String lableText;
  final TextInputType inputType;
  // final Color color;
  final bool readOnly;
  final bool validate;
  final int maxLength;
  final bool isObsureText;
  final TextStyle? lableStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  const CustomTextField1({
    super.key,
    required this.controller,
    required this.hintColor,
    required this.inputType,
    required this.lableText,
    required this.leading,
    // required this.color,
    required this.readOnly,
    this.maxLength = 200,
    this.validate = false,
    this.isObsureText = false,
    this.lableStyle,
    this.inputFormatters,
    this.validator,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  bool isHide = false;

  @override
  void initState() {
    super.initState();
    isHide = widget.isObsureText;
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lableText,
          style: widget.lableStyle ?? body14,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          // height: size.height * 0.06,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(
              obscureText: widget.isObsureText ? isHide : false,
              readOnly: widget.readOnly,
              controller: widget.controller,
              keyboardType: widget.inputType,
              maxLength: widget.maxLength,
              validator: widget.validator ??
                  (v) {
                    if (widget.validate) {
                      if (widget.maxLength == 9) {
                        if (v!.length < 8) {
                          return "phone_number_valid_toast".tr;
                        }
                      }
                      if (v!.isEmpty) {
                        return "";
                      }
                    }
                    return null;
                  },
              inputFormatters: widget.maxLength == 9
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : widget.inputFormatters,
              decoration: InputDecoration(
                counterText: "",
                prefixIcon: widget.leading != ""
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: widget.leading.contains('.png')
                            ? Image.asset(widget.leading)
                            : SvgPicture.asset(widget.leading),
                      )
                    : null,
                isDense: true,
                counterStyle: const TextStyle(color: ColorResources.lightGrey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: ColorResources.dividerColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: ColorResources.dividerColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: ColorResources.dividerColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: ColorResources.primaryRed)),
                hintText: widget.hintColor,
                hintStyle: const TextStyle(color: Color(0xff646F7F)),
                suffixIcon: widget.isObsureText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: Icon(
                            isHide ? Icons.visibility_off : Icons.visibility))
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldWithCountryCode extends StatelessWidget {
  final String hintText;
  final String title;
  final int line;
  final int maxLength;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool validate;
  final bool showCountryCode;
  final String prefix;
  const CustomTextFieldWithCountryCode(
      {Key? key,
      required this.hintText,
      this.title = "",
      required this.controller,
      this.line = 1,
      required this.textInputType,
      this.maxLength = 0,
      this.validate = false,
      this.prefix = "",
      this.showCountryCode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: line,
      maxLength: maxLength == 0 ? null : maxLength,
      controller: controller,
      keyboardType: textInputType,
      validator: (v) {
        if (validate) {
          if (maxLength == 9) {
            if (v!.length < 8) {
              return "phone_number_valid_toast".tr;
            }
          }
          if (v!.isEmpty) {
            return "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: prefix == ""
            ? null
            : prefix.contains(".svg")
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(prefix),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(prefix),
                  ),
        isDense: true,
        prefixText: showCountryCode ? " +996 " : "",
        counterText: "",
        prefixStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xffAFAFAF),
            fontSize: 14,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorResources.dividerColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorResources.dividerColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorResources.dividerColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: ColorResources.dividerColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: ColorResources.dividerColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                BorderSide(color: ColorResources.primaryRed.withOpacity(0.4))),
      ),
    ).paddingOnly(bottom: 10);
  }
}
