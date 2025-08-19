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
    on<UpdatePaymentStatus>(_onUpdatePaymentStatus);
    on<AddPaymentData>(_onAddPaymentData);
    on<GetContractDetail>(_onGetContractDetail);
  }

  Future<void> _onGetCompanySales(
      GetCompanySales event, Emitter<ContractsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copywith(isLoading: true, salesContractItems: []));
    } else {
      emit(state.copywith(isSalesLoadingMore: true));
    }
    try {
      final response = await contractRepo.getCompanySales(
          event.companyId, event.currentPage);
      if (response.statusCode == 200) {
        final sales = CompanySalesModel.fromJson(response.body);
        emit(state.copywith(
            salesContractItems:
                List<CompanyContractItem>.from(state.salesContractItems)
                  ..addAll(sales.data?.items ?? []),
            salesContractItemsCurrentPage: sales.data?.currentPage ?? 1,
            salesContractItemsPageSize: sales.data?.totalPages ?? 1));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isLoading: false, isSalesLoadingMore: false));
  }

  Future<void> _onGetCompanyPurchases(
      GetCompanyPurchases event, Emitter<ContractsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copywith(isLoading: true, salesContractItems: []));
    } else {
      emit(state.copywith(isPurchasesLoadingMore: true));
    }
    try {
      final response = await contractRepo.getCompanyPurchases(
          event.companyId, event.currentPage);
      if (response.statusCode == 200) {
        final purchases = CompanySalesModel.fromJson(response.body);
        emit(state.copywith(
            salesContractItems:
                List<CompanyContractItem>.from(state.salesContractItems)
                  ..addAll(purchases.data?.items ?? []),
            //      favoriteProducts: List<ProductListItem>.from(state.favoriteProducts)
            // ..addAll(favoriteProducts.items ?? []),
            purchasesContractItemsCurrentPage: purchases.data?.currentPage ?? 1,
            purchasesContractItemsPageSize: purchases.data?.totalPages ?? 1));
        print(
            'purchases items = ${state.salesContractItems.length} total length = ${purchases.data?.total} ');
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isLoading: false, isPurchasesLoadingMore: false));
  }

  Future<void> _onSignContract(
      SignContract event, Emitter<ContractsState> emit) async {
    emit(state.copywith(isSigning: true));
    try {
      final response = await contractRepo.signContract(
          event.contractId, event.directorName, event.signatureFile);
      if (response.statusCode == 200) {
        // Handle successful signing
        emit(state.copywith(isSigning: false));

        Get.offAll(() => const DashboardScreen());
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

  Future<void> _onUpdatePaymentStatus(
      UpdatePaymentStatus event, Emitter<ContractsState> emit) async {
    emit(state.copywith(isUpdating: true));
    try {
      final response = await contractRepo.updatePaymentStatus(
          event.contractId, event.status);
      if (response.statusCode == 200) {
        // Get.back();
        List<CompanyContractItem> updatedSalesContracts =
            state.salesContractItems.map((item) {
          if (item.id.toString() == event.contractId) {
            return item.copyWith(paymentStatus: event.status);
          }
          return item;
        }).toList();

        // Update payment status in contractDetail if it matches the contract ID
        CompanyContractItem? updatedContractDetail;
        if (state.contractDetail?.id.toString() == event.contractId) {
          updatedContractDetail =
              state.contractDetail?.copyWith(paymentStatus: event.status);
        }

        emit(state.copywith(
            salesContractItems: updatedSalesContracts,
            contractDetail: updatedContractDetail));
        // Handle successful status update
        // updateSalesContractStatus(event.contractId, event.status, emit);
        // Get.offAll(() => const DashboardScreen());
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isUpdating: false));
  }

  Future<void> _onAddPaymentData(
      AddPaymentData event, Emitter<ContractsState> emit) async {
    emit(state.copywith(isAddingPayment: true));
    try {
      final response = await contractRepo.addPaymentData(
          event.contractId, event.note, event.image.path);
      if (response.statusCode == 200) {
        // Handle successful status update
        // updateSalesContractStatus(event.contractId, event.status, emit);
        // Get.offAll(() => const DashboardScreen());
        // here ad to update payment status in contractDetail
        CompanyContractItem? updatedContractDetail;
        if (state.contractDetail?.id.toString() == event.contractId) {
          updatedContractDetail =
              state.contractDetail?.copyWith(paymentStatus: 'processing');
        }
        emit(state.copywith(contractDetail: updatedContractDetail));
        Get.back();
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copywith(isAddingPayment: false, isUpdating: false));
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

  Future<void> _onGetContractDetail(
      GetContractDetail event, Emitter<ContractsState> emit) async {
    try {
      emit(state.copywith(isLoading: true));

      final response = await contractRepo.getContractDetail(event.contractId);

      if (response.statusCode == 200) {
        final contractData =
            CompanyContractItem.fromJson(response.body['data']);
        emit(state.copywith(
          isLoading: false,
          contractDetail: contractData,
        ));
      } else {
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
      print(e.toString());
    }
  }
}
