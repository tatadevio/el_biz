part of 'cities_bloc.dart';

class CitiesState extends Equatable {
  final bool isLoading;
  final List<CityItem> cityItem;
  final bool bottomLoading;
  final List<String> offSetList;
  final int offSet;
  final int pageSize;
  final int currentPageSize;
  final String cityId;
  final String cityName;
  const CitiesState({
    this.isLoading = false,
    this.cityItem = const [],
    this.bottomLoading = false,
    this.offSetList = const [],
    this.offSet = 1,
    this.pageSize = 1,
    this.currentPageSize = 50,
    this.cityId = '',
    this.cityName = '',
  });

  CitiesState copywith({bool? isLoading, List<CityItem>? cityItem, bool? bottomLoading, List<String>? offSetList, int? offSet, int? pageSize, int? currentPageSize, String? cityId, String? cityName}) {
    return CitiesState(
      isLoading: isLoading ?? this.isLoading,
      cityItem: cityItem ?? this.cityItem,
      bottomLoading: bottomLoading ?? this.bottomLoading,
      offSetList: offSetList ?? this.offSetList,
      offSet: offSet ?? this.offSet,
      pageSize: pageSize ?? this.pageSize,
      currentPageSize: currentPageSize ?? this.currentPageSize,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
    );
  }

  @override
  List<Object> get props => [isLoading, cityItem, bottomLoading, offSetList, offSet, pageSize, currentPageSize, cityId, cityName];
}

// final class CitiesInitial extends CitiesState {}
