part of 'material_bloc.dart';

sealed class MaterialEvent extends Equatable {
  const MaterialEvent();

  @override
  List<Object> get props => [];
}

class GetMaterials extends MaterialEvent {
  final int currentPage;
  const GetMaterials({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class SelectMaterila extends MaterialEvent {
  final MaterialItem materialItem;
  const SelectMaterila(this.materialItem);

  @override
  List<Object> get props => [materialItem];
}
