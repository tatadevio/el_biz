import 'package:el_biz/data/model/response/agreement/my_sales_model.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/agreement/payment_methods_model.dart';
import '../../data/repo/agreement_repo.dart';

part 'agreement_event.dart';
part 'agreement_state.dart';

class AgreementBloc extends Bloc<AgreementEvent, AgreementState> {
  final AgreementRepo agreementRepo;
  AgreementBloc(this.agreementRepo) : super(AgreementInitial()) {
    on<AgreementEvent>((event, emit) {});

    on<GetPaymentMethod>(_onGetPaymentMethod);
    on<AddAgreement>(_onAddAgreement);
    on<GetMySales>(_onGetMySales);
    on<GetMyPurchases>(_onGetMyPurchases);
  }

  Future<void> _onGetPaymentMethod(
      GetPaymentMethod event, Emitter<AgreementState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, paymentMethods: []));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final response = await agreementRepo.getPaymentMethod();
      if (response.statusCode == 200) {
        final payment = PaymentMethodsModel.fromJson(response.body);
        emit(state.copyWith(
            paymentMethods:
                List<PaymentMethod>.from(payment.data?.items ?? [])));
      } else {
        // emit(PaymentMethodError('Failed to load payment methods'));
      }
    } catch (e) {
      // emit(PaymentMethodError(e.toString()));
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }

  Future<void> _onAddAgreement(
      AddAgreement event, Emitter<AgreementState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await agreementRepo.addAgreement(event.data);

      if (response.statusCode == 200) {
        emit(AddAgreementSuccess(
            response.body['message'] ?? 'Agreement added successfully'));
      } else {
        emit(AddAgreementError(
            'Failed to add agreement: ${response.body['message'] ?? 'Unknown error'}'));
      }
    } catch (e) {
      emit(AddAgreementError('Exception occurred: $e'));
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onGetMySales(
      GetMySales event, Emitter<AgreementState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, mySales: []));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final response = await agreementRepo.getMySales(event.currentPage);
      if (response.statusCode == 200) {
        final sales = MySalesModel.fromJson(response.body);
        if (event.currentPage == 1) {
          emit(state.copyWith(mySales: []));
        }

        // response.body['data']['items'] as List;
        emit(state.copyWith(
            mySales: List<CompanyItem>.from(sales.data?.items ?? [])
              ..addAll(state.mySales)));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }

  Future<void> _onGetMyPurchases(
      GetMyPurchases event, Emitter<AgreementState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, myPurchases: []));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final response = await agreementRepo.getMyPurchases(event.currentPage);
      if (response.statusCode == 200) {
        final purchase = MySalesModel.fromJson(response.body);
        if (event.currentPage == 1) {
          emit(state.copyWith(myPurchases: []));
        }
        // response.body['data']['items'] as List;
        emit(state.copyWith(
            myPurchases: List<CompanyItem>.from(purchase.data?.items ?? [])
              ..addAll(state.myPurchases)));
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }
}
