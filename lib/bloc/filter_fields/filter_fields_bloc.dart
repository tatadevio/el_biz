import 'package:el_biz/data/model/response/filter/filter_fields_model.dart';
import 'package:el_biz/data/repo/filter_fields_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_fields_event.dart';
part 'filter_fields_state.dart';

class FilterFieldsBloc extends Bloc<FilterFieldsEvent, FilterFieldsState> {
  final FilterFieldsRepo filterFieldsRepo;
  FilterFieldsBloc(this.filterFieldsRepo) : super(FilterFieldsInitial()) {
    on<FilterFieldsEvent>((event, emit) {});
    on<GetFilterFields>(_onGetFilterFields);
  }

  Future<void> _onGetFilterFields(
      GetFilterFields event, Emitter<FilterFieldsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await filterFieldsRepo.getFilterFields();
      if (response.statusCode == 200) {
        final filterData = FilterFieldsModel.fromJson(response.body);
        emit(state.copyWith(filterFieldsModel: filterData));
      } else {
        showShortToast(response.body['message']);
      }
    } catch (e) {
      showShortToast(e.toString());
    }
    emit(state.copyWith(isLoading: false));
  }
}
