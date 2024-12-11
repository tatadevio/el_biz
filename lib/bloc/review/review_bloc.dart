import 'dart:io';

import 'package:el_biz/data/repo/review_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepo reviewRepo;
  ReviewBloc(this.reviewRepo) : super(ReviewState()) {
    on<PickImageDocs>(_onPickImageDocs);
    on<PickImageDocsCamera>(_onPickImageDocsCamera);
    on<RemoveGallery>(_onRemoveImage);
  }

  Future<void> _onPickImageDocs(
    PickImageDocs event,
    Emitter<ReviewState> emit,
  ) async {
    final picker = ImagePicker();
    final List<XFile>? value = await picker.pickMultiImage(maxWidth: 1024);

    if (value != null) {
      final List<XFile> newImages = [];
      for (var file in value) {
        final compressedImage = await _convertHEICtoJPG(File(file.path));
        newImages.add(compressedImage);
      }
      emit(ReviewState(pickedLogo: [...state.pickedLogo, ...newImages]));
    }
  }

  Future<void> _onPickImageDocsCamera(
    PickImageDocsCamera event,
    Emitter<ReviewState> emit,
  ) async {
    final picker = ImagePicker();
    final XFile? value = await picker.pickImage(source: ImageSource.camera, maxWidth: 1024);

    if (value != null) {
      final compressedImage = await _convertHEICtoJPG(File(value.path));
      emit(ReviewState(pickedLogo: [...state.pickedLogo, compressedImage]));
    }
  }

  void _onRemoveImage(
    RemoveGallery event,
    Emitter<ReviewState> emit,
  ) {
    final updatedImages = List<XFile>.from(state.pickedLogo)..remove(event.image);
    emit(ReviewState(pickedLogo: updatedImages));
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
