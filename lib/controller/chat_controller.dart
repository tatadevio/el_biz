import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/base/response_model.dart';
import '../data/model/response/chat/chat_model.dart';
import '../data/model/response/chat/chatting_product_model.dart';
import '../data/repo/chat_repo.dart';

class ChatController extends GetxController implements GetxService {
  final ChatRepo chatRepo;

  ChatController(this.chatRepo);

  bool _isShowChat = true;
  bool _isShowAllMessage = true;
  bool _isShowMySales = false;

  bool get isShowChat => _isShowChat;
  bool get isShowAllMessage => _isShowAllMessage;
  bool get isShowMySales => _isShowMySales;

  void updateShowChat(bool showChat) {
    _isShowChat = showChat;
    update();
  }

  void updateShowAllMessages(bool showAllMessages) {
    _isShowAllMessage = showAllMessages;
    update();
  }

  void updateShowMySales(bool showMySales) {
    _isShowMySales = showMySales;
    update();
  }

  List<ChatList> _chatList = [];
  bool _isLoading = false;
  bool _bottomLoading = false;
  int _pageSize = 1;
  int _currentPageSize = 1;
  List<String> _offsetList = [];
  int _offset = 1;
  String _receiverImage = '';
  String _receiverName = '';
  String _receiverPhone = '';
  String _productImage = '';
  String _productName = '';
  String _productId = '';
  String _productPrice = '';
  String _productCurrency = '';
  XFile _imageFile = XFile('');
  bool _isSendButtonActive = false;
  bool _imageLoading = false;
  List<bool> _showDate = [];
  List<TicketItem> _ticketList = [];

  String get receiverImage => _receiverImage;
  String get receiverName => _receiverName;
  String get receiverPhone => _receiverPhone;
  String get productImage => _productImage;
  String get productName => _productName;
  String get productId => _productId;
  String get productPrice => _productPrice;
  String get productCurrency => _productCurrency;
  bool get isLoading => _isLoading;
  bool get bottomLoading => _bottomLoading;
  int get pageSize => _pageSize;
  int get currentPageSize => _currentPageSize;
  List<String> get offsetList => _offsetList;
  int get offset => _offset;
  List<bool> get showDate => _showDate != null ? _showDate.reversed.toList() : _showDate;
  List<ChatList> get chatList => _chatList != null ? _chatList.reversed.toList() : _chatList;
  XFile get imageFile => _imageFile;
  bool get isSendButtonActive => _isSendButtonActive;
  bool get imageLoading => _imageLoading;
  List<TicketItem> get ticketList => _ticketList;

  @override
  void onInit() {
    super.onInit();
    // if (Get.find<AuthController>().isLoggedIn()) {
    //   getTicket(true);
    // }
  }

  void getChatList(String id, int pageSize, bool reload) async {
    if (reload) {
      _isLoading = true;
      _chatList.clear();
      update();
    }
    _imageFile = XFile('');
    Response response = await chatRepo.getChatList(id, pageSize.toString());
    print(response.body);
    if (response.statusCode == 200) {
      _showDate = [];
      if (response.body['data']['items'].length > 0) {
        if (_bottomLoading) {
          print("here");
          for (int i = 0; i < ChatModel.fromJson(response.body).data.items.length; i++) {
            //_chatList.add(ChatModel.fromJson(response.body).data.items.reversed.toList()[i]);
            _chatList.insert(0, ChatModel.fromJson(response.body).data.items[i]);
          }
        } else
          _chatList = ChatModel.fromJson(response.body).data.items.reversed.toList();
      }
      // _chatList = ChatModel.fromJson(response.body).data.items.reversed.toList();
      _receiverImage = ChatModel.fromJson(response.body).data.receiver.image;
      _receiverPhone = ChatModel.fromJson(response.body).data.receiver.phone;
      _productName = ChatModel.fromJson(response.body).data.product.name;
      _productImage = ChatModel.fromJson(response.body).data.product.image;
      _productId = ChatModel.fromJson(response.body).data.product.id.toString();
      _productPrice = ChatModel.fromJson(response.body).data.product.price.toString();
      _receiverName = ChatModel.fromJson(response.body).data.receiver.name;
      _pageSize = ChatModel.fromJson(response.body).data.totalPages;
      _currentPageSize = ChatModel.fromJson(response.body).data.currentPage;
      /*_chats.forEach((chat) {
        ChatList chatModel = ChatModel.fromJson(chat).data.items;
        DateTime _originalDateTime = DateConverter.isoStringToLocalDate(chatModel.data.items[0].createdAt.toString());
        DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
        bool _addDate = false;
        if(!_dateList.contains(_convertedDate)) {
          _addDate = true;
          _dateList.add(_convertedDate);
        }
        _chatList.add(chatModel);
        _showDate.add(_addDate);
      });*/
      for (int i = 0; i < _chatList.length; i++) _showDate.add(false);
      update();
    } else {
      //ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    _bottomLoading = false;
    update();
    // Get.find<ConfigController>().getConfig();
  }

  void updateProduct(String name, String image) {
    _productName = name;
    _productImage = image;
    update();
  }

  Future<ResponseModel> sendMessage(String productId, String message) async {
    ResponseModel responseModel;
    Response response = await chatRepo.sendMessage(productId, message);
    if (response.statusCode == 200) {
      getChatList(productId, 1, false);
      getTicket(false);
      responseModel = ResponseModel(true, "Success");
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getTicket(bool reload) async {
    if (reload) {
      _isLoading = true;
    }
    update();
    Response response = await chatRepo.getTicketList();
    if (response.statusCode == 200) {
      print("ticket lenth is");
      _ticketList.clear();
      _ticketList.addAll(ChattingTicketModel.fromJson(response.body).data.items);
      print(_ticketList.length);
      update();
    } else {}
    _isLoading = false;
    update();
  }

  Future<ResponseModel> getSearchUserList(bool reload, String query) async {
    ResponseModel responseModel;
    if (reload) {
      _isLoading = true;
    }
    update();
    Response response = await chatRepo.getSearchTicketList(query);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _ticketList.clear();
      _ticketList.addAll(ChattingTicketModel.fromJson(response.body).data.items);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteMessage(String id, ChatList chat) async {
    _chatList.remove(chat);
    ResponseModel responseModel;
    update();
    Response response = await chatRepo.deleteMessage(id);
    if (response.statusCode == 200) {
      //getChatList(id,1,false);
      responseModel = ResponseModel(true, "Success");
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> clearAllMessage(String id) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await chatRepo.clearMessage(id);
    if (response.statusCode == 200) {
      getTicket(true);
      responseModel = ResponseModel(true, "Success");
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> sendImage(String ticketId) async {
    _imageLoading = true;
    dynamic response = await chatRepo.sendImage(ticketId, _imageFile);
    if (response.statusCode == 200) {
      if (_imageFile != null) {
        getChatList(ticketId, 1, false);
      } else {}
    } else {
      print('${response} ');
    }
    _imageFile = XFile('');
    _imageLoading = false;
    update();
  }

  void setImage(XFile image, String ticketId) {
    _imageFile = image;
    if (_imageFile.path.isNotEmpty) sendImage(ticketId);
    update();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    update();
  }
}
