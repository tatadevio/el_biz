import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repo/tenders_repo.dart';

class TendersController extends GetxController implements GetxService {
  final TendersRepo tendersRepo;

  TendersController(this.tendersRepo);

  bool _isGridView = false;

  bool get isGridView => _isGridView;

  void updateGridView(bool gridView) {
    _isGridView = gridView;
    update();
  }
}
