import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/post.dart';

class PostsApi {
  static Future<List<PostsModel>?> getPosts({
    required int page,
    required int limit,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          "https://jsonplaceholder.typicode.com/posts/?_page=$page&_limit=$limit",
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<PostsModel> posts = body
            .map((e) => PostsModel.fromJson(e))
            .toList();
        return posts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
