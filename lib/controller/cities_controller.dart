import 'package:get/get.dart';

import '../data/model/response/cities_model.dart';
import '../data/repo/cities_repo.dart';

class CitiesController extends GetxController implements GetxService {
  final CitiesRepo citiesRepo;

  CitiesController(this.citiesRepo);

  bool _isLoading = false;

  List<CityItem> _cityItem = [];
  bool _bottomLoading = false;
  late int _pageSize;
  List<String> _offsetList = [];
  int _offset = 1;
  int _currentPageSize = 50;
  String _cityId = '';
  String _cityName = '';

  bool get isLoading => _isLoading;
  List<CityItem> get cityItem => _cityItem;
  bool get bottomLoading => _bottomLoading;
  int get pageSize => _pageSize;
  int get offset => _offset;
  int get currentPageSize => _currentPageSize;
  List<String> get offsetList => _offsetList;
  String get cityId => _cityId;
  String get cityName => _cityName;

  @override
  void onInit() {
    super.onInit();
    getCities(50, true);
  }

  Future<void> getCities(int pageSize, bool reload) async {
    if (reload) {
      if (_cityItem.isEmpty) {
        _isLoading = true;
      }
    } else {
      _bottomLoading = true;
    }
    update();
    Response response = await citiesRepo.getCities(pageSize.toString());
    if (response.statusCode == 200) {
      _cityItem.addAll(CitesModel.fromJson(response.body).data.items);

      if (reload) {
        _cityItem.clear();
      }
      for (int i = 0; i < CitesModel.fromJson(response.body).data.items.length; i++) {
        _cityItem.add(CitesModel.fromJson(response.body).data.items[i]);
      }
      _pageSize = CitesModel.fromJson(response.body).data.perPage;
      _currentPageSize = CitesModel.fromJson(response.body).data.currentPage;

      print(response.body);
      update();
    } else {}

    _isLoading = false;
    _bottomLoading = false;
    update();
  }

  void showBottomLoader() {
    _bottomLoading = true;
    update();
  }

  void changeCity(String id, String name) {
    _cityId = id;
    _cityName = name;
    update();
  }
}
