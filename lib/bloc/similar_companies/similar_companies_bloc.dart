import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/response/company/my_companies_model.dart';
import '../../data/repo/similar_company_repo.dart';

part 'similar_companies_event.dart';
part 'similar_companies_state.dart';

class SimilarCompaniesBloc
    extends Bloc<SimilarCompaniesEvent, SimilarCompaniesState> {
  final SimilarCompanyRepo similarCompanyRepo;
  SimilarCompaniesBloc(this.similarCompanyRepo)
      : super(SimilarCompaniesInitial()) {
    on<SimilarCompaniesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetSimilarCompanies>(_onGetSimilarCompanies);
  }

  Future<void> _onGetSimilarCompanies(
      GetSimilarCompanies event, Emitter<SimilarCompaniesState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final res = await similarCompanyRepo.getSimilarCompanies(
          event.companyId, event.currentPage);
      if (res.statusCode == 200) {
        if (event.currentPage == 1) {
          emit(
            state.copyWith(
              similarCompanies: [],
            ),
          );
        }
        MyCompaniesModel myCompanies = MyCompaniesModel.fromJson(res.body);
        List<CompanyItem> similarCompanies = myCompanies.data?.items ?? [];
        emit(state.copyWith(
            similarCompanies: List<CompanyItem>.from(state.similarCompanies)
              ..addAll(similarCompanies),
            isLoading: false,
            isMoreLoading: false,
            currentPage: myCompanies.data?.currentPage ?? 1,
            totalPages: myCompanies.data?.totalPages ?? 1));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isMoreLoading: false));
    }
  }
}
