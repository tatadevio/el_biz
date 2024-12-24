import 'package:el_biz/data/repo/compnay_repo.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/base/compnay_document_model.dart';
import '../../data/model/base/timing_date_model.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompnayRepo compnayRepo;
  CompanyBloc(this.compnayRepo)
      : super(CompanyState(
          companyDocuments: [
            ComapnyDocumentModel(
              id: '1',
              title: 'Договор на реализацию садовой мебели для кофейни.pdf',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'file',
            ),
            ComapnyDocumentModel(
              id: '2',
              title: 'Каталог садовых стульев.pdf',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'file',
            ),
            ComapnyDocumentModel(
              id: '3',
              title: 'Каталог садовых стульев.jpg',
              size: '1.2 MB',
              date: '5 ноября 2024г.',
              urlLink: '',
              documentType: 'image',
            ),
          ],
        )) {
    on<UpdateShowGood>((event, emit) {
      emit(state.copywith(isShowActiveGoods: event.showActive));
    });

    on<UpdateShowTenders>((event, emit) {
      emit(state.copywith(isShowActiveTenders: event.showActive));
    });

    on<UpdateShowGoodsGridView>((event, emit) {
      emit(state.copywith(isShowGoodsGridView: event.showGridView));
    });

    on<UpdateShowTendersGridView>((event, emit) {
      emit(state.copywith(isShowTendersGridView: event.showGridView));
    });

    on<UpdateDay>(_onUpdateDay);
  }
  void _onUpdateDay(UpdateDay event, Emitter<CompanyState> emit) {
    final updatedSchedule = List<DaySchedule>.from(state.scheduleTiming);
    // updatedSchedule[event.index] = updatedSchedule[event.index].copyWith(isOpen: event.value);

    updatedSchedule[event.index].isOpen = event.value;
    emit(state.copywith(scheduleTiming: updatedSchedule));

    for (int i = 0; i < updatedSchedule.length; i++) {
      print("schedule value ${updatedSchedule[i].toJson()}");
    }
  }
}
