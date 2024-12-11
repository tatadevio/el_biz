// import 'package:el_biz/bloc/cities/cities_bloc.dart';
// import 'package:el_biz/data/model/response/cities_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'dart:convert';
// import '../data/model/base/response_model.dart';
// import '../data/model/response/attribute_model.dart';
// import '../data/model/response/product/add_attribute_model.dart';
// import '../data/model/response/product/edit_ads_model.dart';
// import '../data/model/response/product/product_model.dart';
// import '../data/repo/post_ad_repo.dart';

// class PostAdController extends GetxController implements GetxService {
//   final PostAdRepo postAdRepo;

//   PostAdController(this.postAdRepo);

//   bool _isLoading = false;
//   bool _isEdit = false;

//   List<XFile> _pickedLogo = [];
//   XFile? _featuredImage = XFile("");
//   String _description = '';
//   String _selectedCurrency = 'KGS';
//   String _price = '';
//   String _title = '';

//   String _selectedCategoryId = '';
//   String _parentCatId = '';
//   String _selectedCategory = '';
//   String _selectedCityId = '';
//   String _selectedCityName = '';
//   List<String> _selectedCategoryName = [];
//   List<AttributeData> _attributeItem = [];
//   List<AddAttribute> _addAttributeList = [];
//   List<AddAttributeInt> _addAttributeListInt = [];
//   List<AddAttributeMulti> _addAttributeListMulti = [];
//   List<String> _attributeIndex = [];
//   List<String> _attributeIndexInt = [];
//   List<String> _attributeIndexMulti = [];
//   List<ProductItem> _activeAds = [];
//   List<ProductItem> _inActiveAds = [];
//   List<ProductItem> _pendingAds = [];
//   EditAdsModel? _editAds;
//   int _selectedIndex = 0;
//   int _typeIndex = 0;
//   String _phoneCountry = "+996";
//   String _whatsappCountry = "+996";
//   final List<List<String>> _contactList = [[], [], [], [], [], []];

//   bool _enablePhone = false;
//   String _additionalInfo = "";
//   String _socialLink = "";
//   String _whatsapp = "";
//   String _phone = "";
//   String _locationAddress = "";
//   String _latitude = "0.0";
//   String _longitude = "0.0";
//   ProductItem? _shareProduct;

//   String get phone => _phone;
//   String get locationAddress => _locationAddress;
//   String get latitude => _latitude;
//   String get longitude => _longitude;
//   String get whatsapp => _whatsapp;
//   String get socialLink => _socialLink;
//   String get additionalInfo => _additionalInfo;
//   bool get enablePhone => _enablePhone;
//   bool get isLoading => _isLoading;
//   bool get isEdit => _isEdit;
//   List<XFile> get pickedLogo => _pickedLogo;
//   XFile? get featuredImage => _featuredImage;
//   String get description => _description;
//   String get title => _title;
//   String get selectedCurrency => _selectedCurrency;
//   String get price => _price;
//   String get selectedCategoryId => _selectedCategoryId;
//   String get parentCatId => _parentCatId;
//   String get selectedCategory => _selectedCategory;
//   String get selectedCityId => _selectedCityId;
//   String get selectedCityName => _selectedCityName;
//   List<String> get selectedCategoryName => _selectedCategoryName;
//   List<AttributeData> get attributeItem => _attributeItem;
//   List<AddAttribute> get addAttributeList => _addAttributeList;
//   List<AddAttributeInt> get addAttributeListInt => _addAttributeListInt;
//   List<AddAttributeMulti> get addAttributeListMulti => _addAttributeListMulti;
//   List<String> get attributeIndex => _attributeIndex;
//   List<String> get attributeIndexInt => _attributeIndexInt;
//   List<String> get attributeIndexMulti => _attributeIndexMulti;
//   List<ProductItem> get activeAds => _activeAds;
//   List<ProductItem> get pendingAds => _pendingAds;
//   List<ProductItem> get inActiveAds => _inActiveAds;
//   EditAdsModel? get editAds => _editAds;
//   int get selectedIndex => _selectedIndex;
//   int get typeIndex => _typeIndex;
//   String get phoneCountry => _phoneCountry;
//   String get whatsappCountry => _whatsappCountry;
//   List<List<String>> get contactList => _contactList;
//   ProductItem? get shareProduct => _shareProduct;

//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   if (Get.find<AuthController>().isLoggedIn()) {
//   //     getMyAds("active");
//   //     getMyAds("inactive");
//   //     getMyAds("pending");
//   //   }
//   // }

//   void shareProductItem(ProductItem value) {
//     _shareProduct = value;
//     update();
//   }

//   void addLocationAddress(String address, String latitude, String longitude) {
//     _locationAddress = address;
//     _longitude = longitude;
//     _latitude = latitude;
//     update();
//   }

//   void changeIndex(int index) {
//     _selectedIndex = index;
//     update();
//   }

//   void addContact(List<List<String>> value) {
//     for (int i = 0; i < value.length; i++) {
//       if (value[i].isNotEmpty) {
//         // Check if there are existing values for this contact type
//         if (_contactList[i].isEmpty) {
//           // If empty, add the new values
//           _contactList[i] = List.from(value[i]);
//         } else {
//           // Append new values to the existing list
//           _contactList[i].addAll(value[i]);
//         }
//       }
//     }
//     update(); // Update the UI
//   }

//   void changePhoneCountry(String code) {
//     _phoneCountry = code;
//     update();
//   }

//   void changeWhatsappCountry(String code) {
//     _whatsappCountry = code;
//     update();
//   }

//   void changeParentCatId(String id) {
//     _parentCatId = id;
//     update();
//   }

//   Future<void> getMyAds(String status) async {
//     _isLoading = true;
//     update();
//     Response response = await postAdRepo.getMyAds(status);
//     if (response.statusCode == 200) {
//       if (status == "active") {
//         _activeAds.clear();
//         _activeAds.addAll(ProductListModel.fromJson(response.body).data.items);
//       } else if (status == "inactive") {
//         _inActiveAds.clear();
//         _inActiveAds.addAll(ProductListModel.fromJson(response.body).data.items);
//       } else if (status == "pending") {
//         _pendingAds.clear();
//         _pendingAds.addAll(ProductListModel.fromJson(response.body).data.items);
//       }
//       update();
//     } else {}

//     _isLoading = false;
//     update();
//   }

//   Future<void> removeImage(String id) async {
//     update();
//     Response response = await postAdRepo.removeImage(id);
//     if (response.statusCode == 200) {
//     } else {}
//     update();
//   }

//   Future<void> getEditAds(String id, BuildContext context) async {
//     _isLoading = true;
//     update();
//     Response response = await postAdRepo.getEditAds(id);
//     if (response.statusCode == 200) {
//       _editAds = EditAdsModel.fromJson(response.body);

//       print("edit ad is ${response.body['data']}");
//       getAttributes(_editAds!.data.categoryId.toString(), true);
//       _selectedCategoryName.clear();
//       for (int i = 0; i < _editAds!.data.parentCats.length; i++) {
//         _selectedCategoryName.add(_editAds!.data.parentCats[i].title);
//       }

//       if (_editAds!.data.phoneCountryCode != "") {
//         _phoneCountry = _editAds!.data.phoneCountryCode;
//         _whatsappCountry = _editAds!.data.whatsappCountryCode;
//       }
//       _addAttributeList.clear();
//       _selectedCurrency = _editAds!.data.currency;
//       addLocationAddress(_editAds!.data.address, _editAds!.data.latitude, _editAds!.data.longitude);
//       getCityValue(context);
//       changeEnablePhone(_editAds!.data.enablePhone == 1 ? true : false);
//       update();
//     } else {}

//     _isLoading = false;
//     update();
//   }

//   void getCityValue(BuildContext context) {
//     _selectedCityId = _editAds!.data.cityId.toString();
//     _selectedCategoryId = _editAds!.data.categoryId.toString();
//     _selectedCategory = _editAds!.data.parentCats[_editAds!.data.parentCats.length - 1].title;
//     final cityItems = context.read<CitiesBloc>().state.cityItem;
//     for (int i = 0; i < cityItems.length; i++) {
//       if (_selectedCityId == cityItems[i].id.toString()) {
//         _selectedCityName = cityItems[i].name;
//         _selectedCityId = cityItems[i].id.toString();
//         print(_selectedCityName);
//         print("coty name");
//       }
//     }
//   }

//   Future<void> getAttributes(String id, bool isEdit) async {
//     updateEmpty();
//     _isLoading = true;
//     update();
//     Response response = await postAdRepo.getAttributes(id);
//     if (response.statusCode == 200) {
//       _attributeIndex.clear();
//       _attributeItem.clear();
//       _attributeItem.addAll(AttributeModel.fromJson(response.body).data);

//       print("attributes is${_attributeItem}");
//       if (isEdit) {
//         for (int j = 0; j < _editAds!.data.attribute.length; j++) {
//           if (_attributeItem[j].type == "select") {
//             if (_editAds!.data.attribute[j].option != "") {
//               print(_editAds!.data.attribute[j].id == _attributeItem[j].id && _editAds!.data.attribute[j].option != "");
//               for (int i = 0; i < _attributeItem[j].options.length; i++) {
//                 if (_editAds!.data.attribute[j].option == _attributeItem[j].options[i].id.toString()) {
//                   _addAttributeList.add(AddAttribute(
//                     _attributeItem[j].options[i].id.toString(),
//                     _editAds!.data.attribute[j].id.toString(),
//                     _attributeItem[j].options[i].name,
//                   ));
//                   _attributeIndex.add(j.toString());
//                 }
//               }
//             } else if (_editAds!.data.attribute[j].id == _attributeItem[j].id) {
//               _addAttributeList.add(AddAttribute("", _editAds!.data.attribute[j].id.toString(), ""));
//               _attributeIndex.add(j.toString());
//             }
//           } else if (_attributeItem[j].type == "multiselect") {
//             List<String> res = [];
//             List<String> id = [];
//             for (int i = 0; i < _attributeItem[j].options.length; i++) {
//               if (_attributeItem[j].options[i].id.toString() == _editAds!.data.attribute[j].option.trim()) {
//                 res.add(_attributeItem[j].options[i].name);
//                 id.add(_editAds!.data.attribute[j].option.trim());
//               }
//             }
//             _addAttributeList.add(AddAttribute(
//               id.toString().replaceAll("[", "").replaceAll("]", ""),
//               _editAds!.data.attribute[j].id.toString(),
//               res.toString().replaceAll("[", "").replaceAll("]", ""),
//             ));
//             _attributeIndex.add(j.toString());
//           } else {
//             _addAttributeList.add(AddAttribute(_editAds!.data.attribute[j].option, _editAds!.data.attribute[j].id.toString(), _editAds!.data.attribute[j].option));
//             _attributeIndex.add(j.toString());
//           }
//         }
//       }
//       update();
//     } else {}
//     _isLoading = false;
//     update();
//   }

//   Future<ResponseModel> addProduct(String id, String lat, String long, List<List<String>> contacts) async {
//     ResponseModel responseModel;
//     _isEdit = true;
//     update();
//     dynamic response = await postAdRepo.sellProduct(
//         name: _title,
//         document: _pickedLogo,
//         description: _description,
//         price: _price,
//         cityId: _selectedCityId,
//         catId: _selectedCategoryId,
//         currency: _selectedCurrency,
//         attribute: _addAttributeList,
//         id: id,
//         lat: lat,
//         long: long,
//         address: _locationAddress,
//         contactList: contacts);

//     Map map = jsonDecode(response.body);
//     print(map);
//     if (response.statusCode == 200) {
//       getMyAds("active");
//       responseModel = ResponseModel(true, map['message']);
//       _featuredImage = XFile("");
//       _pickedLogo.clear();
//       _longitude = "0.0";
//       _latitude = "0.0";
//       _locationAddress = "";
//       update();
//     } else {
//       responseModel = ResponseModel(false, map['message']);
//     }
//     _isEdit = false;
//     update();
//     return responseModel;
//   }

//   Future<ResponseModel> deleteAds(String id, String status) async {
//     ResponseModel responseModel;
//     _isLoading = true;
//     update();
//     Response response = await postAdRepo.deleteAds(id);
//     if (response.statusCode == 200) {
//       Get.find<PostAdController>().getMyAds(status);

//       responseModel = ResponseModel(true, "Success");
//       update();
//     } else {
//       responseModel = ResponseModel(false, "Failure");
//     }
//     _isLoading = false;
//     update();
//     return responseModel;
//   }

//   // void pickImageDocs() async {
//   //   List<XFile> value  = (await ImagePicker().pickMultiImage(maxWidth: 1024));
//   //   for(int i = 0; i<value.length; i++){
//   //     _pickedLogo.add(await convertHEICtoJPG(File(value[i].path)));
//   //   }
//   //   print("piked image is${_pickedLogo[0].path}");
//   //   update();
//   // }

//   // void pickImageDocsCamera() async {
//   //   XFile value  = (await ImagePicker().pickImage(maxWidth: 1024, source: ImageSource.camera))!;
//   //   _pickedLogo.add(await convertHEICtoJPG(File(value.path)));
//   //   print("piked image is${_pickedLogo[0].path}");
//   //   update();
//   // }

//   // void pickImageFeatured() async {
//   //   _featuredImage = (await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 1024));
//   //   _featuredImage = await convertHEICtoJPG(File(_featuredImage!.path));
//   //   print(_featuredImage?.path);
//   //   update();
//   // }

//   void addTitleDes(String title, String price, String description) {
//     _title = title;
//     _price = price;
//     _description = description;
//   }

//   void selectCurrency(String value) {
//     _selectedCurrency = value;
//     update();
//   }

//   void updatePrice(String value) {
//     _price = value;
//     update();
//   }

//   void updateCityId(String value, String name) {
//     _selectedCityId = value;
//     _selectedCityName = name;
//     update();
//   }

//   void removeGallery(int index) {
//     _pickedLogo.removeAt(index);
//     update();
//   }

//   void updateCategoryId(String value, String name) {
//     _selectedCategoryId = value;
//     _selectedCategory = name;
//     print("category id is $_selectedCategoryId");
//     print("category id is $_selectedCategory");
//     getAttributes(value, false);
//     update();
//   }

//   void addCategoryName(String name, bool reload) {
//     _selectedCategoryName.add(name);
//     update();
//   }

//   void makeCategoryEmpty() {
//     _selectedCategoryName.clear();
//     update();
//   }

//   void makeClearIds() {
//     _selectedCategoryName.clear();
//   }

//   void editAttribute(AddAttribute value, String index, bool replace) {
//     if (replace && _addAttributeList.length > int.parse(index)) {
//       _addAttributeList.removeAt(int.parse(index));
//       _addAttributeList.insert(int.parse(index), value);
//     } else {
//       _addAttributeList.add(value);
//       _attributeIndex.add(index);
//     }
//     //print(jsonEncode(_addAttributeList));
//     update();
//   }

//   void editAttributeMulti(AddAttributeMulti value, String index, bool replace) {
//     if (replace && _addAttributeList.length > int.parse(index)) {
//       _addAttributeListMulti.removeAt(int.parse(index));
//       _addAttributeListMulti.insert(int.parse(index), value);
//     } else {
//       _addAttributeListMulti.add(value);
//       _attributeIndexMulti.add(index);
//     }
//     //print(jsonEncode(_addAttributeListMulti));
//     update();
//   }

//   void editAttributeInt(AddAttributeInt value, String index) {
//     _addAttributeListInt.add(value);
//     _attributeIndexInt.add(index);
//     //print(jsonEncode(_addAttributeListInt));
//     update();
//   }

//   void updateEmpty() {
//     _addAttributeList.clear();
//     _addAttributeListMulti.clear();
//     _addAttributeListInt.clear();
//     _attributeIndex.clear();
//     update();
//   }

//   void whileCancelMakeEmpty() {
//     _pickedLogo.clear();
//     _selectedCategoryId = "";
//     _selectedCategory = "";
//     _addAttributeList.clear();
//     _addAttributeListMulti.clear();
//     _addAttributeListInt.clear();
//     _attributeIndex.clear();
//     _locationAddress = "";
//     _latitude = "";
//     _longitude = "";
//     update();
//   }

//   void changeEnablePhone(bool val) {
//     _enablePhone = val;
//     update();
//   }

//   void changeAdditionalInfo(String social, String additionalInfo, String whatsapp, String phone) {
//     _socialLink = social;
//     _additionalInfo = additionalInfo;
//     _whatsapp = whatsapp;
//     _phone = phone;
//     update();
//   }

//   void removeOldGallery(int index, String id) {
//     _editAds!.data.galleries.removeAt(index);
//     removeImage(id);
//     update();
//   }

//   // void makeImageEmpty(){
//   //   pickImageFeatured();
//   // }

//   // Future<XFile> convertHEICtoJPG(File heicFile) async {
//   //   final tempDir = await getTemporaryDirectory();
//   //   final tempPath = tempDir.path;

//   //   final result = await FlutterImageCompress.compressAndGetFile(
//   //     heicFile.path,
//   //     '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
//   //     quality: 100,
//   //     format: CompressFormat.jpeg,
//   //   );
//   //   return result!;
//   // }

//   void changeTypeIndex(int value) {
//     _typeIndex = value;
//     update();
//   }
// }
