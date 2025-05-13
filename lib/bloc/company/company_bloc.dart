import 'dart:io';

import 'package:el_biz/data/model/base/add_company_model.dart';
import 'package:el_biz/data/repo/compnay_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:el_biz/view/screen/home/home_screen.dart';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/base/timing_date_model.dart';
import '../../data/model/response/company/my_companies_model.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompnayRepo compnayRepo;
  CompanyBloc(this.compnayRepo)
      : super(
          CompanyState(addCompanyModel: AddCompanyModel()),
        ) {
    on<GetMyCompanies>((event, emit) async {
      // emit(state.copywith(isLoading: true)); // emits loading state
      final res = await compnayRepo.getMyCompanies();
      MyCompaniesModel myCompanies = MyCompaniesModel.fromJson(res.body);
      List<CompanyItem> myCompaniesList = myCompanies.data?.items ?? [];
      emit(state.copywith(myCompanies: myCompaniesList)); // emits updated state
    });

    on<DeleteCompany>(_onDeleteCompany);

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

    on<AddNewCompany>(_onAddNewCompany);
    on<UpdateCompany>(_onUpdateCompany);
  }

  // void _onGetMyCompanies(GetMyCompanies event, Emitter<CompanyState> emit) {}
  Future<void> _onDeleteCompany(
      DeleteCompany event, Emitter<CompanyState> emit) async {
    emit(state.copywith(isLoading: true));
    final res = await compnayRepo.deleteCompany(event.id);
    if (res.statusCode == 200) {
      emit(state.copywith(isLoading: false));
      Get.back();
      add(GetMyCompanies());
    } else {
      emit(state.copywith(isLoading: false));
    }
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

  Future<void> _onAddNewCompany(
      AddNewCompany event, Emitter<CompanyState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final res = await compnayRepo.addNewCompany(event.addCompanyModel);

      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(state.copywith(isLoading: false));
        HomeScreen().loadCompanyData(event.context);
        Get.offAll(() => DashboardScreen());
        emit(state.copywith(addCompanyModel: AddCompanyModel()));
      } else {
        emit(state.copywith(isLoading: false));
        // AddCompanyError(res.body['message']);
        showShortToast(res.body['message']);
      }
    } catch (e) {
      // AddCompanyError(e.toString());
      showShortToast(e.toString());
    }
  }

  Future<void> _onUpdateCompany(
      UpdateCompany event, Emitter<CompanyState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final res = await compnayRepo.addNewCompany(event.addCompanyModel,
          isUpdate: true, companyId: event.companyId);

      if (res.statusCode == 200 || res.statusCode == 201) {
        emit(state.copywith(isLoading: false));
        HomeScreen().loadCompanyData(event.context);
        Get.offAll(() => DashboardScreen());
        emit(state.copywith(addCompanyModel: AddCompanyModel()));
      } else {
        emit(state.copywith(isLoading: false));
        // AddCompanyError(res.body['message']);
        showShortToast(res.body['message']);
      }
    } catch (e) {
      showShortToast(e.toString());
    }
  }
}
