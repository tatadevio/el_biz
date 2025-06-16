import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/response/agreement/company_sales_model.dart';
import '../../view/screen/dashboard/dashboard.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractRepo contractRepo;
  ContractsBloc(this.contractRepo) : super(ContractsState()) {
    on<ContractsEvent>((event, emit) {});
    on<GetCompanySales>(_onGetCompanySales);
    on<GetCompanyPurchases>(_onGetCompanyPurchases);
    on<SignContract>(_onSignContract);
    on<UpdateContractStatus>(_onUpdateContractStatus);
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

  Future<void> _onSignContract(
      SignContract event, Emitter<ContractsState> emit) async {
    emit(state.copywith(isSigning: true));
    try {
      final response = await contractRepo.signContract(
          event.contractId, event.directorName, event.signatureFile);
      if (response.statusCode == 200) {
        // Handle successful signing
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isSigning: false));
  }

  Future<void> _onUpdateContractStatus(
      UpdateContractStatus event, Emitter<ContractsState> emit) async {
    emit(state.copywith(isUpdating: true));
    try {
      final response = await contractRepo.updateContractStatus(
          event.contractId, event.status);
      if (response.statusCode == 200) {
        // Handle successful status update
        // updateSalesContractStatus(event.contractId, event.status, emit);
        Get.offAll(() => const DashboardScreen());
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isUpdating: false));
  }

  // updateSalesContractStatus(
  //     String contractId, String status, Emitter<ContractsState> emit) {
  //   List<CompanyContractItem> updatedSalesContracts =
  //       state.salesContractItems.map((item) {
  //     if (item.id.toString() == contractId.toString()) {
  //       return item.copyWith(status: 'status');
  //     }
  //     return item;
  //   }).toList();

  //   emit(state.copywith(salesContractItems: updatedSalesContracts));
  // }
}
