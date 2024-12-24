import 'dart:io';

import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/tenders/tenders_bloc.dart';
import '../../../bloc/tenders/tenders_state.dart';
import '../../../utils/Images.dart';
import '../../base/custom_dialog.dart';

class NewTende2Screen extends StatefulWidget {
  const NewTende2Screen({super.key});

  @override
  State<NewTende2Screen> createState() => _NewTende2ScreenState();
}

class _NewTende2ScreenState extends State<NewTende2Screen> {
  final TextEditingController tenderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать новый тендер'),
      ),
      body: BlocBuilder<TendersBloc, TendersState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Что вы хотите купить?',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              CustomTextField1(
                controller: tenderController,
                hintColor: 'Без кавычек, например: B2B',
                inputType: TextInputType.text,
                lableText: 'Без кавычек, например: B2B',
                leading: '',
                readOnly: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Фото',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Добавьте фото товара, которое вы ищете',
                style: body14,
              ),
              const SizedBox(
                height: 10,
              ),
              if (state.pickedLogo.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.pickedLogo
                      .map(
                        (image) => Stack(
                          children: [
                            ClipRRect(
                              // height: 80,
                              // width: 80,
                              borderRadius: BorderRadius.circular(12),

                              child: Image.file(
                                File(image.path),
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // reviewController.removeGallery(image);
                                // context.read<ReviewBloc>().add(RemoveGallery(image));
                              },
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: SvgPicture.asset(Images.svgTrash),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Get.dialog(CustomDialog(
                          widget: SimpleDialog(
                        title: const Text('Select Image'),
                        children: [
                          ListTile(
                            onTap: () {
                              Get.back();
                              // reviewController.pickImageDocsCamera();
                              // context.read<ReviewBloc>().add(PickImageDocsCamera());
                            },
                            leading: const Icon(Icons.camera),
                            title: Text('Camera'),
                          ),
                          ListTile(
                            onTap: () {
                              Get.back();
                              // reviewController.pickImageDocs();
                              // context.read<ReviewBloc>().add(PickImageDocs());
                            },
                            leading: const Icon(Icons.image),
                            title: Text('Galler'),
                          ),
                        ],
                      )));
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ColorResources.lgColor),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Images.svgPlus,
                        height: 32,
                        width: 32,
                        color: ColorResources.gray,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
