part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isShowChat;
  final String isShowAllMessage;
  final bool isShowMySales;
  final List<ChatItem> chatProductList;
  final List<ChatItem> chatTenderList;
  final List<ChatItem> chatCompanyList;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  final bool isLoadingTenderMore;
  final int currentTenderPage;
  final int pageTenderSize;
  final String productSearchQuery;
  final String tenderSearchQuery;
  final String companySearchQuery;
  final List<ChatItem> filteredChatProductList;
  final List<ChatItem> filteredChatTenderList;
  final List<ChatItem> filteredChatCompanyList;
  final bool isSearchingProducts;
  final bool isSearchingTenders;
  final bool isSearchingCompany;
  final bool isLoadingProductSearchMore;
  final bool isLoadingTenderSearchMore;
  final bool isLoadingCompanySearchMore;
  final int productSearchCurrentPage;
  final int tenderSearchCurrentPage;
  final int companySearchCurrentPage;
  final int productSearchPageSize;
  final int tenderSearchPageSize;
  final int companySearchPageSize;
  const ChatState({
    this.isShowChat = true,
    this.isShowAllMessage = 'message', // 'message', 'tender', 'company'
    this.isShowMySales = false,
    this.chatProductList = const [],
    this.chatTenderList = const [],
    this.chatCompanyList = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.isLoadingTenderMore = false,
    this.currentTenderPage = 1,
    this.pageTenderSize = 1,
    this.productSearchQuery = '',
    this.tenderSearchQuery = '',
    this.companySearchQuery = '',
    this.filteredChatProductList = const [],
    this.filteredChatTenderList = const [],
    this.filteredChatCompanyList = const [],
    this.isSearchingProducts = false,
    this.isSearchingTenders = false,
    this.isSearchingCompany = false,
    this.isLoadingProductSearchMore = false,
    this.isLoadingTenderSearchMore = false,
    this.isLoadingCompanySearchMore = false,
    this.productSearchCurrentPage = 1,
    this.tenderSearchCurrentPage = 1,
    this.companySearchCurrentPage = 1,
    this.productSearchPageSize = 1,
    this.tenderSearchPageSize = 1,
    this.companySearchPageSize = 1,
  });

  ChatState copyWith({
    bool? isShowChat,
    String? isShowAllMessage,
    bool? isShowMySales,
    List<ChatItem>? chatProductList,
    List<ChatItem>? chatTenderList,
    List<ChatItem>? chatCompanyList,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
    bool? isLoadingTenderMore,
    int? currentTenderPage,
    int? pageTenderSize,
    String? productSearchQuery,
    String? tenderSearchQuery,
    String? companySearchQuery,
    List<ChatItem>? filteredChatProductList,
    List<ChatItem>? filteredChatTenderList,
    List<ChatItem>? filteredChatCompanyList,
    bool? isSearchingProducts,
    bool? isSearchingTenders,
    bool? isSearchingCompany,
    bool? isLoadingProductSearchMore,
    bool? isLoadingTenderSearchMore,
    bool? isLoadingCompanySearchMore,
    int? productSearchCurrentPage,
    int? tenderSearchCurrentPage,
    int? companySearchCurrentPage,
    int? productSearchPageSize,
    int? tenderSearchPageSize,
    int? companySearchPageSize,
  }) {
    return ChatState(
      isShowChat: isShowChat ?? this.isShowChat,
      isShowAllMessage: isShowAllMessage ?? this.isShowAllMessage,
      isShowMySales: isShowMySales ?? this.isShowMySales,
      chatProductList: chatProductList ?? this.chatProductList,
      chatTenderList: chatTenderList ?? this.chatTenderList,
      chatCompanyList: chatCompanyList ?? this.chatCompanyList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isLoadingTenderMore: isLoadingTenderMore ?? this.isLoadingTenderMore,
      currentTenderPage: currentTenderPage ?? this.currentTenderPage,
      pageTenderSize: pageTenderSize ?? this.pageTenderSize,
      productSearchQuery: productSearchQuery ?? this.productSearchQuery,
      tenderSearchQuery: tenderSearchQuery ?? this.tenderSearchQuery,
      companySearchQuery: companySearchQuery ?? this.companySearchQuery,
      filteredChatProductList:
          filteredChatProductList ?? this.filteredChatProductList,
      filteredChatTenderList:
          filteredChatTenderList ?? this.filteredChatTenderList,
      filteredChatCompanyList:
          filteredChatCompanyList ?? this.filteredChatCompanyList,
      isSearchingProducts: isSearchingProducts ?? this.isSearchingProducts,
      isSearchingTenders: isSearchingTenders ?? this.isSearchingTenders,
      isSearchingCompany: isSearchingCompany ?? this.isSearchingCompany,
      isLoadingProductSearchMore:
          isLoadingProductSearchMore ?? this.isLoadingProductSearchMore,
      isLoadingTenderSearchMore:
          isLoadingTenderSearchMore ?? this.isLoadingTenderSearchMore,
      isLoadingCompanySearchMore:
          isLoadingCompanySearchMore ?? this.isLoadingCompanySearchMore,
      productSearchCurrentPage:
          productSearchCurrentPage ?? this.productSearchCurrentPage,
      tenderSearchCurrentPage:
          tenderSearchCurrentPage ?? this.tenderSearchCurrentPage,
      companySearchCurrentPage:
          companySearchCurrentPage ?? this.companySearchCurrentPage,
      productSearchPageSize:
          productSearchPageSize ?? this.productSearchPageSize,
      tenderSearchPageSize: tenderSearchPageSize ?? this.tenderSearchPageSize,
      companySearchPageSize:
          companySearchPageSize ?? this.companySearchPageSize,
    );
  }

  @override
  List<Object> get props => [
        isShowChat,
        isShowAllMessage,
        isShowMySales,
        chatProductList,
        chatTenderList,
        chatCompanyList,
        isLoading,
        isLoadingMore,
        currentPage,
        pageSize,
        isLoadingTenderMore,
        currentTenderPage,
        pageTenderSize,
        productSearchQuery,
        tenderSearchQuery,
        companySearchQuery,
        filteredChatProductList,
        filteredChatTenderList,
        filteredChatCompanyList,
        isSearchingProducts,
        isSearchingTenders,
        isSearchingCompany,
        isLoadingProductSearchMore,
        isLoadingTenderSearchMore,
        isLoadingCompanySearchMore,
        productSearchCurrentPage,
        tenderSearchCurrentPage,
        companySearchCurrentPage,
        productSearchPageSize,
        tenderSearchPageSize,
        companySearchPageSize,
      ];
}

class SendMediaSuccess extends ChatState {
  final String url;
  const SendMediaSuccess(this.url);
}

class SendMediaError extends ChatState {
  final String error;
  const SendMediaError(this.error);
}
