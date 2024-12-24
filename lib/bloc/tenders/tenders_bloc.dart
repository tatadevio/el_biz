import 'dart:io';

import 'package:el_biz/bloc/tenders/tenders_event.dart';
import 'package:el_biz/data/repo/tenders_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'tenders_state.dart';

class TendersBloc extends Bloc<TendersEvent, TendersState> {
  final TendersRepo tendersRepo;
  TendersBloc(this.tendersRepo) : super(const TendersState()) {
    on<UpdateGridView>(_updateToggleShowGridView);
    on<FetchAllTenders>(_fetchAllTenders);
    on<PickImageDocs>(_onPickImageDocs);
    on<PickImageDocsCamera>(_onPickImageDocsCamera);
    on<RemoveGallery>(_onRemoveImage);
  }

  void _updateToggleShowGridView(UpdateGridView event, Emitter<TendersState> emit) {
    emit(state.copywith(isGridView: event.isGridView));
  }

  void _fetchAllTenders(event, emit) async {
    emit(state.copywith(isLoading: true));
    try {
      // final response = await tendersRepo.fetchAllTenders(event.offset);
      // if (response.statusCode == 200) {
      //   print('API response = success');
      // } else {
      //   print('API response = failed');
      // }
    } catch (e) {
      print('Error fetching tenders: $e');
    }
    emit(state.copywith(isLoading: false));
  }

  Future<void> _onPickImageDocs(
    PickImageDocs event,
    Emitter<TendersState> emit,
  ) async {
    final picker = ImagePicker();
    final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

    if (value != null) {
      final List<XFile> newImages = [];
      for (var file in value) {
        final compressedImage = await _convertHEICtoJPG(File(file.path));
        newImages.add(compressedImage);
      }
      emit(TendersState(pickedLogo: [...state.pickedLogo, ...newImages]));
    }
  }

  Future<void> _onPickImageDocsCamera(
    PickImageDocsCamera event,
    Emitter<TendersState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value = await picker.pickImage(source: ImageSource.camera, maxWidth: 1024);

    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));
      emit(TendersState(pickedLogo: [...state.pickedLogo, compressedImage]));
    }
  }

  void _onRemoveImage(
    RemoveGallery event,
    Emitter<TendersState> emit,
  ) {
    final updatedImages = List<XFile>.from(state.pickedLogo)..remove(event.image);
    emit(TendersState(pickedLogo: updatedImages));
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
