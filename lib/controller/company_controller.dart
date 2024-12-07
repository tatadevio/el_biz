import 'package:el_biz/data/repo/compnay_repo.dart';
import 'package:get/get.dart';

class ComapnyDocumentModel {
  final String id;
  final String title;
  final String size;
  final String date;
  final String urlLink;
  final String documentType;

  ComapnyDocumentModel({required this.id, required this.title, required this.size, required this.date, required this.urlLink, required this.documentType});
}

class CompanyController extends GetxController implements GetxService {
  final CompnayRepo compnayRepo;
  CompanyController(this.compnayRepo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ComapnyDocumentModel> _companyDocuments = [
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
  ];
  List<ComapnyDocumentModel> get companyDocuments => _companyDocuments;

  bool _isShowActiveGoods = true;
  bool _isShowActiveTenders = true;
  bool _isShowGoodsGridView = true;
  bool _isShowTendersGridview = true;

  bool get isShowActiveGoods => _isShowActiveGoods;
  bool get isShowActiveTenders => _isShowActiveTenders;
  bool get isShowGoodsGridView => _isShowGoodsGridView;
  bool get isShowTendersGridView => _isShowTendersGridview;

  void updateShowGood(bool showActive) {
    _isShowActiveGoods = showActive;
    update();
  }

  void updateShowTenders(bool showActive) {
    _isShowActiveTenders = showActive;
    update();
  }

  void updateShowGoodsGridView(bool showGridView) {
    _isShowGoodsGridView = showGridView;
    update();
  }

  void updateShowTendersGridView(bool showGridView) {
    _isShowTendersGridview = showGridView;
    update();
  }
}
