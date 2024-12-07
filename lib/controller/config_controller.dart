import 'package:get/get.dart';

import '../data/model/response/config_model.dart';
import '../data/model/response/pages_model.dart';
import '../data/repo/config_repo.dart';

class ConfigController extends GetxController implements GetxService {
  final ConfigRepo configRepo;

  ConfigController(this.configRepo);

  bool _isLoading = false;
  PagesModel? _privacy;
  PagesModel? _terms;
  PagesModel? _about;
  int _selectedIndex = 0;
  ConfigModel? _configModel;

  bool get isLoading => _isLoading;
  PagesModel? get privacy => _privacy;
  PagesModel? get terms => _terms;
  PagesModel? get about => _about;
  ConfigModel? get configModel => _configModel;
  int get selectedIndex => _selectedIndex;

  @override
  void onInit() {
    super.onInit();
    getPrivacy();
    getTerms();
    getAbout();
    getConfig();
  }

  Future<void> getPrivacy() async {
    _isLoading = true;
    update();
    Response response = await configRepo.getPrivacy();
    if (response.statusCode == 200) {
      _privacy = PagesModel.fromJson(response.body);
      print(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> getTerms() async {
    _isLoading = true;
    update();
    Response response = await configRepo.getTerms();
    if (response.statusCode == 200) {
      _privacy = PagesModel.fromJson(response.body);
      print(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> getAbout() async {
    _isLoading = true;
    update();
    Response response = await configRepo.getAbout();
    if (response.statusCode == 200) {
      _privacy = PagesModel.fromJson(response.body);
      print(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> getConfig() async {
    _isLoading = true;
    update();
    Response response = await configRepo.getConfig();
    if (response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }

  void changeIndex(int value) {
    _selectedIndex = value;
    update();
  }
}
