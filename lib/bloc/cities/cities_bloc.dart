import 'package:el_biz/data/repo/cities_repo.dart';
import 'package:el_biz/helper/get_di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/cities_model.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final CitiesRepo citiesRepo;
  CitiesBloc(this.citiesRepo) : super(const CitiesState()) {
    on<GetCitites>(_fetchCities);

    on<ShowBottomLoader>((event, emit) {
      emit(state.copywith(bottomLoading: true));
    });

    on<ChangeCity>((event, emit) {
      emit(state.copywith(cityId: event.id, cityName: event.name));
    });
  }

  Future<void> _fetchCities(GetCitites event, Emitter<CitiesState> emit) async {
    if (event.reload) {
      emit(state.copywith(isLoading: true));
    } else {
      emit(state.copywith(bottomLoading: true));
    }

    try {
      final response = await citiesRepo.getCities(event.pageSize.toString());
      if (response.statusCode == 200) {
        final model = CitesModel.fromJson(response.body);

        final updatedCities = event.reload ? model.data.items : List<CityItem>.from(state.cityItem)
          ..addAll(model.data.items);

        emit(state.copywith(
          isLoading: false,
          bottomLoading: false,
          cityItem: updatedCities,
          pageSize: model.data.perPage,
          currentPageSize: model.data.currentPage,
        ));
      } else {
        // Handle error
        emit(state.copywith(isLoading: false, bottomLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false, bottomLoading: false));
    }
  }
}
