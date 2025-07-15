import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/model/response/account/my_accounts_model.dart';
import '../../data/repo/account_repo.dart';
import '../../view/base/custom_toast.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepo accountRepo;
  AccountBloc(this.accountRepo) : super(AccountState()) {
    // on<AccountEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<GetMyAccounts>(_onGetMyAccounts);
    on<AddAccount>(_onAddAccount);
    on<UpdateAccount>(_onUpdateAccount);
    on<DeleteAccount>(_onDeleteAccount);
    on<MakePrimaryAccount>(_onMakePrimaryAccount);
  }

  void _onGetMyAccounts(GetMyAccounts event, Emitter<AccountState> emit) async {
    if (event.currentPage == 1 || event.currentPage == null) {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(accountItems: []));
    } else {
      emit(state.copyWith(moreLoading: true));
    }
    final response = await accountRepo.getMyAccounts(event.currentPage ?? 1);
    if (response.statusCode == 200) {
      final data = MyAccountsModel.fromJson(response.body);
      final List<AccountItem> newAccountItems = data.data?.items ?? [];

      emit(state.copyWith(
        isLoading: false,
        accountItems: List<AccountItem>.from(state.accountItems)
          ..addAll(newAccountItems),
        currentPage: data.data?.currentPage,
        pageSize: data.data?.totalPages,
      ));
    } else {
      emit(state.copyWith(isLoading: false));
    }
    emit(state.copyWith(isLoading: false, moreLoading: false));
  }

  void _onAddAccount(AddAccount event, Emitter<AccountState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await accountRepo.addAccount(
        event.accountName, event.accountNumber, event.bic);
    showShortToast(response.body['message']);
    if (response.statusCode == 200) {
      emit(state.copyWith(isLoading: false));
      Get.back();
      add(GetMyAccounts());
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onUpdateAccount(UpdateAccount event, Emitter<AccountState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await accountRepo.updateAccount(
        event.id, event.accountName, event.accountNumber, event.bic);
    showShortToast(response.body['message']);
    if (response.statusCode == 200) {
      emit(state.copyWith(isLoading: false));
      Get.back();
      add(GetMyAccounts());
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onDeleteAccount(DeleteAccount event, Emitter<AccountState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await accountRepo.deleteAccount(event.id);
    showCustomSnackBar(response.body['message']);
    if (response.statusCode == 200) {
      emit(state.copyWith(isLoading: false));
      Get.back();
      add(GetMyAccounts());
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onMakePrimaryAccount(
      MakePrimaryAccount event, Emitter<AccountState> emit) async {
    // emit(state.copyWith(isLoading: true));
    final response = await accountRepo.makePrimaryAccount(event.id);
    showShortToast(response.body['message']);
    if (response.statusCode == 200) {
      // emit(state.copyWith(isLoading: false));
      final updatedAccountItems = state.accountItems.map((account) {
        if (account.id == event.id) {
          return account.copyWith(primaryAccount: 1);
        } else {
          return account.copyWith(primaryAccount: 0);
        }
      }).toList();
      emit(state.copyWith(accountItems: updatedAccountItems));

      // Get.back();
      // add(GetMyAccounts());
    } else {
      // emit(state.copyWith(isLoading: false));
    }
  }
}
