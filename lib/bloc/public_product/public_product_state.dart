part of 'public_product_bloc.dart';

sealed class PublicProductState extends Equatable {
  const PublicProductState();
  
  @override
  List<Object> get props => [];
}

final class PublicProductInitial extends PublicProductState {}
