import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/base/contract_model.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractRepo contractRepo;
  ContractsBloc(this.contractRepo)
      : super(ContractsState(contracts: [
          ContractModel(
            id: '1',
            title: 'Договор №1',
            subTitle: 'Садовая мебель для кофейни',
            status: 'Ожидает согласования',
            paymentStatus: 'Оплачен',
            date: '12 сен. 2024',
            contractName: 'Садовая мебель',
            numberOfGoods: '40 шт',
            price: '100 000.00 сом',
            document: 'Посмотреть',
          ),
          ContractModel(
            id: '2',
            title: 'Договор №1',
            subTitle: 'Садовая мебель для кофейни',
            status: 'Подписан',
            paymentStatus: 'Оплачен',
            date: '12 сен. 2024',
            contractName: 'Садовая мебель',
            numberOfGoods: '40 шт',
            price: '100 000.00 сом',
            document: 'Посмотреть',
          ),
          ContractModel(
            id: '3',
            title: 'Договор №1',
            subTitle: 'Садовая мебель для кофейни',
            status: 'Отклонён',
            paymentStatus: 'Не оплачен',
            date: '12 сен. 2024',
            contractName: 'Садовая мебель',
            numberOfGoods: '40 шт',
            price: '100 000.00 сом',
            document: 'Посмотреть',
          ),
        ])) {
    on<ContractsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
