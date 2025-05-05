part of 'public_tender_bloc.dart';

sealed class PublicTenderState extends Equatable {
  const PublicTenderState();
  
  @override
  List<Object> get props => [];
}

final class PublicTenderInitial extends PublicTenderState {}
