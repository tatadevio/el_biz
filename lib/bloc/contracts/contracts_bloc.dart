import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/agreement/company_sales_model.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractRepo contractRepo;
  ContractsBloc(this.contractRepo) : super(ContractsState(
            // contracts: [
            //   ContractModel(
            //     id: '1',
            //     title: 'Договор №1',
            //     subTitle: 'Садовая мебель для кофейни',
            //     status: 'Ожидает согласования',
            //     paymentStatus: 'Оплачен',
            //     date: '12 сен. 2024',
            //     contractName: 'Садовая мебель',
            //     numberOfGoods: '40 шт',
            //     price: '100 000.00 сом',
            //     document: 'Посмотреть',
            //   ),
            //   ContractModel(
            //     id: '2',
            //     title: 'Договор №1',
            //     subTitle: 'Садовая мебель для кофейни',
            //     status: 'Подписан',
            //     paymentStatus: 'Оплачен',
            //     date: '12 сен. 2024',
            //     contractName: 'Садовая мебель',
            //     numberOfGoods: '40 шт',
            //     price: '100 000.00 сом',
            //     document: 'Посмотреть',
            //   ),
            //   ContractModel(
            //     id: '3',
            //     title: 'Договор №1',
            //     subTitle: 'Садовая мебель для кофейни',
            //     status: 'Отклонён',
            //     paymentStatus: 'Не оплачен',
            //     date: '12 сен. 2024',
            //     contractName: 'Садовая мебель',
            //     numberOfGoods: '40 шт',
            //     price: '100 000.00 сом',
            //     document: 'Посмотреть',
            //   ),
            // ]

            )) {
    on<ContractsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetCompanySales>(_onGetCompanySales);
    on<GetCompanyPurchases>(_onGetCompanyPurchases);
  }

  Future<void> _onGetCompanySales(
      GetCompanySales event, Emitter<ContractsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copywith(isLoading: true, salesContractItems: []));
    } else {
      emit(state.copywith(isLoadingMore: true));
    }
    try {
      final response = await contractRepo.getCompanySales(
          event.companyId, event.currentPage);
      if (response.statusCode == 200) {
        final sales = CompanySalesModel.fromJson(response.body);
        emit(state.copywith(
            salesContractItems:
                List<CompanyContractItem>.from(sales.data?.items ?? [])));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isLoading: false, isLoadingMore: false));
  }

  Future<void> _onGetCompanyPurchases(
      GetCompanyPurchases event, Emitter<ContractsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copywith(isLoading: true, salesContractItems: []));
    } else {
      emit(state.copywith(isLoadingMore: true));
    }
    try {
      final response = await contractRepo.getCompanyPurchases(
          event.companyId, event.currentPage);
      if (response.statusCode == 200) {
        final purchases = CompanySalesModel.fromJson(response.body);
        emit(state.copywith(
            salesContractItems:
                List<CompanyContractItem>.from(purchases.data?.items ?? [])));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isLoading: false, isLoadingMore: false));
  }
}
