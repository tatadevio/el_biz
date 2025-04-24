part of 'add_tender_bloc.dart';

sealed class AddTenderEvent extends Equatable {
  const AddTenderEvent();

  @override
  List<Object> get props => [];
}

class AddNewTender extends AddTenderEvent {
  final AddTenderModel addTenderModel;
  const AddNewTender({required this.addTenderModel});

  @override
  List<Object> get props => [addTenderModel];
}
