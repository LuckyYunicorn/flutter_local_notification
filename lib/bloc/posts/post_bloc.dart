import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_notification/model/post.dart';

import '../../api_methods/post_api.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState()) {
    on<FetchPost>(_fetchPosts);
  }
  Future<void> _fetchPosts(FetchPost event, Emitter<PostState> emit) async {
    if (state.isLoading && !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      if(event.resetPage){
        emit(state.copyWith(postsList: [], page: 1,));
      }
      print("page ${state.page} AND limit ${state.limit}");
      List<PostsModel>? posts = await PostsApi.getPosts(
        page: state.page,
        limit: state.limit,
      );

      if (posts != null && posts.isNotEmpty) {
        emit(
          state.copyWith(
            postsList: [...state.postsList, ...posts],
            isLoading: false,
            page: state.page + 1,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false, hasMore: false));
      }

    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
