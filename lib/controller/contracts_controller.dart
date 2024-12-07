import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:get/get.dart';

class ContractModel {
  final String id;
  final String title;
  final String subTitle;
  final String status;
  final String paymentStatus;
  final String date;
  final String contractName;
  final String numberOfGoods;
  final String price;
  final String document;
  ContractModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.paymentStatus,
    required this.date,
    required this.contractName,
    required this.numberOfGoods,
    required this.price,
    required this.document,
  });
}

class ContractsController extends GetxController implements GetxService {
  final ContractRepo contractRepo;
  ContractsController(this.contractRepo);

  final List<ContractModel> _contracts = [
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
  ];

  List<ContractModel> get contracts => _contracts;
}
