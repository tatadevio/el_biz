
import 'package:el_biz/data/repo/public_company_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'public_company_event.dart';
part 'public_company_state.dart';

class PublicCompanyBloc extends Bloc<PublicCompanyEvent, PublicCompanyState> {
  final PublicCompanyRepo publicCompanyRepo;
  PublicCompanyBloc(this.publicCompanyRepo) : super(PublicCompanyInitial()) {
    on<PublicCompanyEvent>((event, emit) {});
  }
}
