part of 'post_bloc.dart';

class PostState extends Equatable {
  final int page;
  final int limit;
  final List<PostsModel> postsList;
  final bool isLoading;
  final bool hasMore;

  const PostState({
    this.postsList = const <PostsModel>[],
    this.isLoading = false,
    this.hasMore = true,
    this.page = 1,
    this.limit = 10,
  });

  PostState copyWith({List<PostsModel>? postsList, bool? isLoading,bool? hasMore, int? page, int? limit }) {
    return PostState(
      postsList: postsList ?? this.postsList,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [postsList, isLoading, hasMore];
}
