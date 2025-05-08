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


class UpdateTender extends AddTenderEvent {
  final AddTenderModel addTenderModel;
  final int tenderId;
  const UpdateTender(this.addTenderModel, this.tenderId);

  @override
  List<Object> get props => [addTenderModel, tenderId];
}


class DeleteTenderImage extends AddTenderEvent {
  final String tenderId;
  final String imageId;

  const DeleteTenderImage(this.tenderId, this.imageId);

  @override
  List<Object> get props => [tenderId, imageId];
}


