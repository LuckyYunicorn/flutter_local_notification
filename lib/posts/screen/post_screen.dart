import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/posts/post_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    bool isRequesting = false;
    return BlocProvider(
      create: (context) => PostBloc()..add(FetchPost()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: BlocConsumer<PostBloc, PostState>(
          builder: (context, state) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                context.read<PostBloc>().add(FetchPost(resetPage: true));
              },
              child: NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 50) {
                    if (!state.isLoading && state.hasMore && isRequesting) {
                      context.read<PostBloc>().add(FetchPost());
                      isRequesting = false;
                    }
                  }
                  return false;
                },
                child: state.isLoading && state.postsList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            state.postsList.length +
                                (state.isLoading && state.hasMore ? 1 : 0) ??
                            0,
                        itemBuilder: (context, index) {
                          if (index == state.postsList.length) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text("${state.postsList[index].id ?? ''}"),
                            ),
                            title: Text(
                              state.postsList[index].title ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              maxLines: 2,
                              state.postsList[index].body ?? '',
                            ),
                          );
                        },
                      ),
              ),
            );
          },
          listener: (context, state) {
            if (!state.isLoading && state.hasMore) {
              isRequesting = true;
            }
          },
        ),
      ),
    );
  }
}
