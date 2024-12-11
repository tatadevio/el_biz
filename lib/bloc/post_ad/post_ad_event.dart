part of 'post_ad_bloc.dart';

sealed class PostAdEvent extends Equatable {
  const PostAdEvent();

  @override
  List<Object> get props => [];
}

class UpdateCategoryId extends PostAdEvent {
  final String value;
  final String name;
  const UpdateCategoryId(this.value, this.name);

  @override
  List<Object> get props => [value, name];
}

class UpdateCityId extends PostAdEvent {
  final String value;
  final String name;
  const UpdateCityId(this.value, this.name);

  @override
  List<Object> get props => [value, name];
}

class AddCategoryName extends PostAdEvent {
  final String name;
  final bool reload;
  const AddCategoryName(this.name, this.reload);

  @override
  List<Object> get props => [name, reload];
}
