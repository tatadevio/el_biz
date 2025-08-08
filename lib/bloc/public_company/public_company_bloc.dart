import 'package:el_biz/data/repo/public_company_repo.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/base/company_filter_values_model.dart';
import '../../data/model/response/company/my_companies_model.dart';

part 'public_company_event.dart';
part 'public_company_state.dart';

class PublicCompanyBloc extends Bloc<PublicCompanyEvent, PublicCompanyState> {
  final PublicCompanyRepo publicCompanyRepo;
  PublicCompanyBloc(this.publicCompanyRepo) : super(PublicCompanyInitial()) {
    on<PublicCompanyEvent>((event, emit) {});

    on<GetPublicCompany>(_onGetPublicCompany);
    on<GetNewPublicCompany>(_onGetNewPublicCompany);
    on<UpdateCompanyFilterEnable>(_onUpdateCompanyFilterEnable);
    on<FilterPublicCompanyProduct>(_onFilterPublicCompanyProduct);
    on<ClearPublicCompanyState>(_onClearPublicCompanyState);
    on<DeleteCompanies>(_onDeleteCompany);
  }

  Future<void> _onGetPublicCompany(
      GetPublicCompany event, Emitter<PublicCompanyState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, publicCompanies: []));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final res = await publicCompanyRepo.getMyCompanies(event.currentPage);
      if (res.statusCode == 200) {
        MyCompaniesModel myCompanies = MyCompaniesModel.fromJson(res.body);

        List<CompanyItem> myCompaniesList = myCompanies.data?.items ?? [];
        emit(state.copyWith(
          publicCompanies: List<CompanyItem>.from(state.publicCompanies)
            ..addAll(myCompaniesList),
          companyCurrentPage: myCompanies.data?.currentPage ?? 1,
          companyPageSize: myCompanies.data?.totalPages ?? 1,
        ));
        // have to add the pagination
      } else {
        showShortToast(res.body['message']);
      }
    } catch (e) {
      showShortToast(e.toString());
    }

    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onGetNewPublicCompany(
      GetNewPublicCompany event, Emitter<PublicCompanyState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }
    try {
      final res = await publicCompanyRepo.getNewMyCompanies(event.currentPage);
      if (res.statusCode == 200) {
        MyCompaniesModel myCompanies = MyCompaniesModel.fromJson(res.body);
        if (event.currentPage == 1) {
          emit(state.copyWith(newCompanies: []));
        }

        List<CompanyItem> myCompaniesList = myCompanies.data?.items ?? [];
        print('new companies list length = ${myCompaniesList.length}');
        emit(state.copyWith(
          newCompanies: List<CompanyItem>.from(state.newCompanies)
            ..addAll(myCompaniesList),
          newCompanyCurrentPage: myCompanies.data?.currentPage ?? 1,
          newCompanyPageSize: myCompanies.data?.totalPages ?? 1,
        ));
        print(
            'new companies list length = ${state.newCompanies.length} and ${state.newCompanyCurrentPage} and ${state.newCompanyPageSize}');
        // have to add the pagination
      } else {
        showShortToast(res.body['message']);
      }
    } catch (e) {
      showShortToast(e.toString());
    }

    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onUpdateCompanyFilterEnable(
    UpdateCompanyFilterEnable event,
    Emitter<PublicCompanyState> emit,
  ) async {
    emit(state.copyWith(isFilterEnable: event.isEnable));
  }

  Future<void> _onFilterPublicCompanyProduct(
    FilterPublicCompanyProduct event,
    Emitter<PublicCompanyState> emit,
  ) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(
          isLoading: true,
          isFilterEnable: true,
          companyFilterValuesModel: event.productFilterValuesModel));
    } else {
      emit(state.copyWith(
          isMoreLoading: true,
          isFilterEnable: true,
          companyFilterValuesModel: event.productFilterValuesModel));
    }
    try {
      final response = await publicCompanyRepo.getPublicFilterCompanies(
        categoryId: event.productFilterValuesModel.categoryId ?? '',
        keywords: event.productFilterValuesModel.keywords ?? '',
        highRating: event.productFilterValuesModel.highRating ?? '',
        city: event.productFilterValuesModel.city ?? '',
        isVerified:
            event.productFilterValuesModel.isVerified == true ? '1' : '0',
        page: event.currentPage,
      );

      if (response.statusCode == 200) {
        final companies = MyCompaniesModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            filterCompanies: companies.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            filterCompanies: List<CompanyItem>.from(state.filterCompanies)
              ..addAll(companies.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            filterCurrentPage: companies.data?.currentPage ?? 1,
            filterPageSize: companies.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }

  Future<void> _onClearPublicCompanyState(
    ClearPublicCompanyState event,
    Emitter<PublicCompanyState> emit,
  ) async {
    emit(PublicCompanyInitial());
  }

  Future<void> _onDeleteCompany(
    DeleteCompanies event,
    Emitter<PublicCompanyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Check and remove from all lists that contain the ID
    List<CompanyItem> updatedPublicCompanies = state.publicCompanies;
    List<CompanyItem> updatedNewCompanies = state.newCompanies;
    List<CompanyItem> updatedFilterCompanies = state.filterCompanies;

    // Remove from publicCompanies if it exists
    if (state.publicCompanies
        .any((element) => element.id.toString() == event.id)) {
      updatedPublicCompanies = state.publicCompanies
          .where((element) => element.id.toString() != event.id)
          .toList();
    }

    // Remove from newCompanies if it exists
    if (state.newCompanies
        .any((element) => element.id.toString() == event.id)) {
      updatedNewCompanies = state.newCompanies
          .where((element) => element.id.toString() != event.id)
          .toList();
    }

    // Remove from filterCompanies if it exists
    if (state.filterCompanies
        .any((element) => element.id.toString() == event.id)) {
      updatedFilterCompanies = state.filterCompanies
          .where((element) => element.id.toString() != event.id)
          .toList();
    }

    // Emit the updated state with all potentially modified lists
    emit(state.copyWith(
      publicCompanies: updatedPublicCompanies,
      newCompanies: updatedNewCompanies,
      filterCompanies: updatedFilterCompanies,
      isLoading: false,
    ));
  }
}
