import 'package:bloc/bloc.dart';
import 'package:el_biz/data/model/response/config_model.dart';
import 'package:el_biz/data/model/response/pages_model.dart';
import 'package:el_biz/data/repo/config_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepo configRepo;
  ConfigBloc(this.configRepo) : 
        super( ConfigState(pageController:   PageController(initialPage: 0))){
          
    on<GetPrivacy>(_getPrivacy);
    on<GetTerms>(_getTerms);
    on<GetAbout>(_getAbout);
    on<GetConfig>(_getConfig);

    on<ChangeIndex>((event, emit) {
      emit(state.copywith(selectedIndex: event.value));
    });
  }


  Future<void> _getPrivacy(GetPrivacy event, Emitter<ConfigState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final response = await configRepo.getPrivacy();
      if (response.statusCode == 200) {
        final privacy = PagesModel.fromJson(response.body);
        emit(state.copywith(privacy: privacy));
      } else {
        // Handle error
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
    }
  }

  Future<void> _getTerms(GetTerms event, Emitter<ConfigState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final response = await configRepo.getTerms();
      if (response.statusCode == 200) {
        final terms = PagesModel.fromJson(response.body);
        emit(state.copywith(terms: terms));
      } else {
        // Handle error
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
    }
  }

  Future<void> _getAbout(GetAbout event, Emitter<ConfigState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final response = await configRepo.getAbout();
      if (response.statusCode == 200) {
        final about = PagesModel.fromJson(response.body);
        emit(state.copywith(about: about));
      } else {
        // Handle error
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
    }
  }

  Future<void> _getConfig(GetConfig event, Emitter<ConfigState> emit) async {
    emit(state.copywith(isLoading: true));
    try {
      final response = await configRepo.getConfig();
      if (response.statusCode == 200) {
        final config = ConfigModel.fromJson(response.body);
        emit(state.copywith(configModel: config));
      } else {
        // Handle error
        emit(state.copywith(isLoading: false));
      }
    } catch (e) {
      emit(state.copywith(isLoading: false));
    }
  }
}
