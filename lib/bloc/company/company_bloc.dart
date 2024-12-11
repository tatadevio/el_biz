import 'package:el_biz/data/repo/compnay_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/company_controller.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompnayRepo compnayRepo;
  CompanyBloc(this.compnayRepo) : super(const CompanyState()) {
    on<CompanyEvent>((event, emit) {});
  }
}
