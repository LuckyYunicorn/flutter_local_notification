import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/bloc/posts/post_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _controller = ScrollController();
  bool _isRequesting = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc()..add(FetchPost()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text("My Posts")),
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final state = context.read<PostBloc>().state;

                bool nearBottom =
                    scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 50;
                // only fetch if:
                // 1. near bottom
                // 2. not already loading
                // 3. more data available
                // 4. not already requested this page
                if (nearBottom && !state.isLoading && state.hasMore && !_isRequesting) {

                  _isRequesting = true; // block extra calls
                  // prevPage = page; // mark current page
                  // page++;

                  context.read<PostBloc>().add(
                    FetchPost(),
                  );
                }

                return false;
              },
              child: BlocListener<PostBloc, PostState>(
                listener: (context, state) {
                  // reset flag after API success/failure
                  if (!state.isLoading) {
                    _isRequesting = false;
                  }
                },
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state.isLoading && state.postsList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      controller: _controller,
                      itemCount:
                          state.postsList.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.postsList.length) {
                          return state.isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox();
                        }

                        final post = state.postsList[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text("${post.id}")),
                          title: Text(post.title ?? ''),
                          subtitle: Text(post.body ?? ''),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
