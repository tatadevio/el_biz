import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class TendersState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  // final List<XFile> pickedLogo;
  final AddTenderModel newTenderModel;
  final TenderItem? selectedTender;

  const TendersState({
    this.isLoading = false,
    this.isGridView = true,
    // this.pickedLogo = const [],
    required this.newTenderModel,
    this.selectedTender,
  });

  TendersState copywith({
    bool? isLoading,
    bool? isGridView,
    List<XFile>? pickedLogo,
    AddTenderModel? newTenderModel,
    TenderItem? selectedTender,
  }) {
    return TendersState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      // pickedLogo: pickedLogo ?? this.pickedLogo,
      newTenderModel: newTenderModel ?? this.newTenderModel,
      selectedTender: selectedTender,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isGridView,
        // pickedLogo,
        newTenderModel,
        selectedTender,
      ];
}
