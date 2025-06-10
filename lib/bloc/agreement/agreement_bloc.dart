import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
        // emit(PaymentMethodSuccess(response.body));
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
      print('response status code == ${response.statusCode}');
      print('response body == ${response.body}');
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
}
