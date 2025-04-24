part of 'account_bloc.dart';

class AccountState extends Equatable {
  final bool isLoading;
  final List<AccountItem> accountItems;
  final int pageSize;
  final int currentPage;
  final bool moreLoading;
  const AccountState({
    this.isLoading = false,
    this.accountItems = const [],
    this.pageSize = 1,
    this.currentPage = 1,
    this.moreLoading = false,
  });

  AccountState copyWith({
    bool? isLoading,
    List<AccountItem>? accountItems,
    int? pageSize,
    int? currentPage,
    bool? moreLoading,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      accountItems: accountItems ?? this.accountItems,
      pageSize: pageSize ?? this.pageSize,
      currentPage: currentPage ?? this.currentPage,
      moreLoading: moreLoading ?? this.moreLoading,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, accountItems, pageSize, currentPage, moreLoading];
}

// final class AccountInitial extends AccountState {}
