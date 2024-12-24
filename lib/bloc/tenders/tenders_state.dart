import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class TendersState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final List<XFile> pickedLogo;

  const TendersState({
    this.isLoading = false,
    this.isGridView = true,
    this.pickedLogo = const [],
  });

  TendersState copywith({
    bool? isLoading,
    bool? isGridView,
    List<XFile>? pickedLogo,
  }) {
    return TendersState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      pickedLogo: pickedLogo ?? this.pickedLogo,
    );
  }

  @override
  List<Object?> get props => [isLoading, isGridView, pickedLogo];
}
