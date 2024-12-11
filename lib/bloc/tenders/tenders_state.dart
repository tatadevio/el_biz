import 'package:equatable/equatable.dart';

class TendersState extends Equatable {
  final bool isLoading;
  final bool isGridView;

  const TendersState({this.isLoading = false, this.isGridView = true});

  TendersState copywith({bool? isLoading, bool? isGridView}) {
    return TendersState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
    );
  }

  @override
  List<Object?> get props => [isLoading, isGridView];
}
