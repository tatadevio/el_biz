part of 'add_tender_bloc.dart';

class AddTenderState extends Equatable {
  final bool? isLoading;
  final AddTenderModel? addTenderModel;
  const AddTenderState({
    this.isLoading = false,
    this.addTenderModel,
  });

  AddTenderState copyWith({bool? isLoading, AddTenderModel? addTenderModel}) {
    return AddTenderState(
        isLoading: isLoading ?? this.isLoading,
        addTenderModel: addTenderModel ?? this.addTenderModel);
  }

  @override
  List<Object> get props => [isLoading!, addTenderModel!];
}

final class AddTenderInitial extends AddTenderState {}

final class AddTenderLoader extends AddTenderState {}

final class AddTenderError extends AddTenderState {}

final class AddTenderSuccess extends AddTenderState {}
