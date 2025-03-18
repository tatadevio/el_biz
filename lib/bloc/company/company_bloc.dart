import 'dart:io';

import 'package:el_biz/data/model/base/add_company_model.dart';
import 'package:el_biz/data/repo/compnay_repo.dart';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/base/compnay_document_model.dart';
import '../../data/model/base/timing_date_model.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompnayRepo compnayRepo;
  CompanyBloc(this.compnayRepo)
      : super(
          CompanyState(companyDocuments: [
            ComapnyDocumentModel(
              id: '1',
              title: 'Договор на реализацию садовой мебели для кофейни.pdf',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'file',
            ),
            ComapnyDocumentModel(
              id: '2',
              title: 'Каталог садовых стульев.pdf',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'file',
            ),
            ComapnyDocumentModel(
              id: '3',
              title: 'Каталог садовых стульев.jpg',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'image',
            ),
          ], addCompanyModel: AddCompanyModel()),
        ) {
    on<UpdateShowGood>((event, emit) {
      emit(state.copywith(isShowActiveGoods: event.showActive));
    });

    on<UpdateShowTenders>((event, emit) {
      emit(state.copywith(isShowActiveTenders: event.showActive));
    });

    on<UpdateShowGoodsGridView>((event, emit) {
      emit(state.copywith(isShowGoodsGridView: event.showGridView));
    });

    on<UpdateShowTendersGridView>((event, emit) {
      emit(state.copywith(isShowTendersGridView: event.showGridView));
    });

    on<UpdateDay>(_onUpdateDay);

    on<SelectCompanyLogo>(_selectCompanyLogo);

    on<SelectCompanyBanner>(_selectCompanyBanner);

    on<SelectCompanyDocument>(_selectCompanyDocument);

    on<SelectCompanyOtherDocuments>(_selectCompanyOtherDocuments);

    on<RemoveCompanyOtherDocument>(_removeCompanyOtherDocument);
  }
  void _onUpdateDay(UpdateDay event, Emitter<CompanyState> emit) {
    final updatedSchedule = List<DaySchedule>.from(state.scheduleTiming);
    // updatedSchedule[event.index] = updatedSchedule[event.index].copyWith(isOpen: event.value);

    updatedSchedule[event.index].isOpen = event.value;
    emit(state.copywith(scheduleTiming: updatedSchedule));

    for (int i = 0; i < updatedSchedule.length; i++) {
      print("schedule value ${updatedSchedule[i].toJson()}");
    }
  }

  Future<void> _selectCompanyLogo(
    SelectCompanyLogo event,
    Emitter<CompanyState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value = await picker.pickImage(source: event.imageSource);
    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));
      emit(CompanyState(
          addCompanyModel:
              state.addCompanyModel.copyWith(companyLogo: compressedImage)));
    }
  }

  Future<void> _selectCompanyBanner(
    SelectCompanyBanner event,
    Emitter<CompanyState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value = await picker.pickImage(source: ImageSource.gallery);
    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));
      emit(CompanyState(
          addCompanyModel:
              state.addCompanyModel.copyWith(companyBanner: compressedImage)));
    }
  }

  Future<void> _selectCompanyDocument(
    SelectCompanyDocument event,
    Emitter<CompanyState> emit,
  ) async {
    final picker = ImagePicker();
    if (event.imageSource != null) {
      final XFile? value = await picker.pickImage(source: event.imageSource!);
      if (value != null) {
        final compressedImage = await _convertHEICtoJPG(File(value.path));
        emit(CompanyState(
            addCompanyModel: state.addCompanyModel
                .copyWith(certificateDocument: compressedImage)));
      }
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);
        final xFile = XFile(file.path);
        emit(CompanyState(
          addCompanyModel:
              state.addCompanyModel.copyWith(certificateDocument: xFile),
        ));
      }
    }
  }

  Future<void> _selectCompanyOtherDocuments(
    SelectCompanyOtherDocuments event,
    Emitter<CompanyState> emit,
  ) async {
    final picker = ImagePicker();

    List<XFile>? otherDocuments = state.addCompanyModel.otherDocuments ?? [];

    if (otherDocuments.length >= 10) {
      print("Maximum of 10 documents allowed.");
      return;
    }

    if (event.imageSource == ImageSource.camera) {
      final XFile? value = await picker.pickImage(source: ImageSource.camera);
      if (value != null) {
        final compressedImage = await _convertHEICtoJPG(File(value.path));
        if (otherDocuments.length < 10) {
          otherDocuments.add(compressedImage);
          emit(CompanyState(
            addCompanyModel: state.addCompanyModel.copyWith(
              otherDocuments: otherDocuments,
            ),
          ));
        }
      }
    } else if (event.imageSource == ImageSource.gallery) {
      final List<XFile>? selectedImages = await picker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        int remainingSlots = 10 - otherDocuments.length;
        final List<XFile> imagesToAdd =
            selectedImages.take(remainingSlots).toList();

        for (var image in imagesToAdd) {
          final compressedImage = await _convertHEICtoJPG(File(image.path));
          otherDocuments.add(compressedImage);
        }

        emit(CompanyState(
          addCompanyModel: state.addCompanyModel.copyWith(
            otherDocuments: otherDocuments,
          ),
        ));
      }
    } else if (event.imageSource == null) {
      // Select PDF file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        int remainingSlots = 10 - otherDocuments.length;
        final filesToAdd = result.files.take(remainingSlots);

        for (var file in filesToAdd) {
          final pdfFile = XFile(file.path!);
          otherDocuments.add(pdfFile);
        }

        emit(CompanyState(
          addCompanyModel: state.addCompanyModel.copyWith(
            otherDocuments: otherDocuments,
          ),
        ));
      }
    }
  }

  Future<void> _removeCompanyOtherDocument(
    RemoveCompanyOtherDocument event,
    Emitter<CompanyState> emit,
  ) async {
    List<XFile> updatedDocuments =
        List.from(state.addCompanyModel.otherDocuments!);
    updatedDocuments.removeAt(event.index);

    emit(CompanyState(
      addCompanyModel: state.addCompanyModel.copyWith(
        otherDocuments: updatedDocuments,
      ),
    ));
  }

  Future<XFile> _convertHEICtoJPG(File heicFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    final result = await FlutterImageCompress.compressAndGetFile(
      heicFile.path,
      '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
      quality: 100,
      format: CompressFormat.jpeg,
    );
    return XFile(result!.path);
  }
}
