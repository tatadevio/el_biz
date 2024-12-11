// import 'package:get/get.dart';

// import '../data/model/response/product/product_model.dart';
// import '../data/repo/product_repo.dart';
// import '../view/base/custom_toast.dart';

// class ProductDetailController extends GetxController implements GetxService {
//   final ProductRepo productRepo;

//   ProductDetailController(this.productRepo);

//   bool _showProductReviews = false;
//   bool get showProductReviews => _showProductReviews;

//   toggleShowProductReview(bool isShowReview) {
//     _showProductReviews = isShowReview;
//     update();
//   }

//   bool _isLoading = false;
//   bool _isReport = false;

//   ProductItem? _productDetailModel;
//   String _selectedReport = "";

//   ProductItem? get productDetailModel => _productDetailModel;
//   bool get isLoading => _isLoading;
//   bool get isReport => _isReport;
//   String get selectedReport => _selectedReport;

//   Future<void> getProductDetail(String id) async {
//     _isLoading = true;
//     update();
//     Response response = await productRepo.productDetail(id);
//     if (response.statusCode == 200) {
//       _productDetailModel = ProductItem.fromJson(response.body['data']);
//       print(response.body);
//       update();
//     } else {}

//     _isLoading = false;
//     update();
//   }

//   Future<void> addProductReport(String id, String comment, String description) async {
//     _isReport = true;
//     update();
//     Response response = await productRepo.addReport(id, comment, description);
//     if (response.statusCode == 200) {
//     } else {}
//     _isReport = false;
//     showShortToast("success".tr);
//     Get.back();
//     update();
//   }

//   void changeReport(String value) {
//     _selectedReport = value;
//     update();
//   }

//   void changeFavQuantity(bool increment) {
//     if (_productDetailModel != null) {
//       if (increment) {
//         _productDetailModel!.favorites = 1;
//       } else {
//         _productDetailModel!.favorites = 0;
//       }
//       update();
//     }
//   }

//   void changeStatus(String status) {
//     _productDetailModel!.ownerStatus = status;
//     update();
//   }
// }
