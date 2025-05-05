import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repo/public_product_repo.dart';

part 'public_product_event.dart';
part 'public_product_state.dart';

class PublicProductBloc extends Bloc<PublicProductEvent, PublicProductState> {
  final PublicProductRepo publicProductRepo;
  PublicProductBloc(this.publicProductRepo) : super(PublicProductInitial()) {
    on<PublicProductEvent>((event, emit) {
    });
  }
}
