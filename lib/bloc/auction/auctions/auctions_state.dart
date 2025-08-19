part of 'auctions_bloc.dart';

 class AuctionsState extends Equatable {
    final bool isGridView;
  const AuctionsState({this.isGridView = true});

  AuctionsState copyWith({
    bool? isGridView,
  }) {
    return AuctionsState(
      isGridView: isGridView ?? this.isGridView,
    );
  }
  
  @override
  List<Object> get props => [isGridView];
}

final class AuctionsInitial extends AuctionsState {}
