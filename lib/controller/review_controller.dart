import 'dart:io';

import 'package:el_biz/data/repo/review_repo.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ReviewController extends GetxController implements GetxService {
  final ReviewRepo reviewRepo;
  ReviewController(this.reviewRepo);

  bool _isLoading = false;
  List<XFile> _pickedLogo = [];
  List _myReviews = ['not', 'empty'];

  bool get isLoading => _isLoading;
  List<XFile> get pickedLogo => _pickedLogo;
  List get myReviews => _myReviews;

  void pickImageDocs() async {
    List<XFile> value = (await ImagePicker().pickMultiImage(maxWidth: 1024));
    for (int i = 0; i < value.length; i++) {
      _pickedLogo.add(await convertHEICtoJPG(File(value[i].path)));
    }

    update();
  }

  void pickImageDocsCamera() async {
    XFile value = (await ImagePicker().pickImage(maxWidth: 1024, source: ImageSource.camera))!;
    _pickedLogo.add(await convertHEICtoJPG(File(value.path)));

    update();
  }

  Future<XFile> convertHEICtoJPG(File heicFile) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    final result = await FlutterImageCompress.compressAndGetFile(
      heicFile.path,
      '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
      quality: 100,
      format: CompressFormat.jpeg,
    );
    return result!;
  }

  void removeGallery(XFile image) {
    // _pickedLogo.removeAt(index);
    _pickedLogo.remove(image);

    update();
  }
}
