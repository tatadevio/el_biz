import 'package:bloc/bloc.dart';
import 'package:el_biz/data/model/response/materials_model.dart';
import 'package:el_biz/data/repo/material_repo.dart';
import 'package:equatable/equatable.dart';

part 'material_event.dart';
part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final MaterialRepo materialRepol;
  MaterialBloc(this.materialRepol) : super(MaterialState()) {
    on<MaterialEvent>((event, emit) {});

    on<GetMaterials>(_onGetMaterials);
  }

  Future<void> _onGetMaterials(
      GetMaterials event, Emitter<MaterialState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final response = await materialRepol.getMaterials(event.currentPage);
      if (response.statusCode == 200) {
        final materialData = MaterialsModel.fromJson(response.body);
        int currentPage = materialData.data?.currentPage ?? 1;
        int pageSize = materialData.data?.totalPages ?? 1;
        if (event.currentPage == 1) {
          // emit(MaterialSuccess(materialData.data?.items ?? []));
          emit(state.copyWith(materialItems: materialData.data?.items ?? []));
        } else {
          List<MaterialItem> newItems = [
            ...state.materialItems,
            ...materialData.data?.items ?? [],
          ];
          emit(state.copyWith(materialItems: newItems));
        }
        emit(state.copyWith(pageSize: pageSize, currentPage: currentPage));
      }
    } catch (e) {
      emit(MaterialError(e.toString()));
    }

    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }
}
