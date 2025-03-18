import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class TendersState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  // final List<XFile> pickedLogo;
  final AddTenderModel newTenderModel;

  const TendersState({
    this.isLoading = false,
    this.isGridView = true,
    // this.pickedLogo = const [],
    required this.newTenderModel,
  });

  TendersState copywith({
    bool? isLoading,
    bool? isGridView,
    List<XFile>? pickedLogo,
    AddTenderModel? newTenderModel,
  }) {
    return TendersState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      // pickedLogo: pickedLogo ?? this.pickedLogo,
      newTenderModel: newTenderModel ?? this.newTenderModel,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isGridView,
        // pickedLogo,
        newTenderModel,
      ];
}
