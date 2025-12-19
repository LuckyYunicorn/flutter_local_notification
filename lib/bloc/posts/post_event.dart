part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class FetchPost extends PostEvent {
  final bool resetPage;
  const FetchPost({this.resetPage = false});
  @override
  List<Object?> get props => [resetPage];
}

