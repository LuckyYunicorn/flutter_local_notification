part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class FetchPost extends PostEvent {
  // final int page;
  // final int limit;
  const FetchPost();
  @override
  List<Object?> get props => [];
}

