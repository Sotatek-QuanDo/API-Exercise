import 'package:dio/dio.dart';

import 'package:api_call_test/class/post_description.dart';
import 'package:api_call_test/class/post.dart';
import 'dart:convert';

class DioClient {
  final Dio _dio = Dio();

  Future<void> deleteUser({
    required String id,
  }) async {
    try {
      await _dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getPostData() async {
    List<Post> postList = [];
    try {
      Response postData =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      List<dynamic> jsonData = postData.data;
      postList = jsonData.map((post) => Post.fromJson(post)).toList();
    } on DioError catch (e) {
      rethrow;
    }
    return postList;
  }

  Future<PostDescription> getPostDescription(int id) async {
    late PostDescription description;
    try {
      Response postDescription =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/$id');
      Map<String, dynamic> jsonData = postDescription.data;
      description = PostDescription.fromJson(jsonData);
    } on DioError catch (e) {
      rethrow;
    }
    return description;
  }

  Future<void> addNewPost({
    required int userID,
    required int id,
    required String title,
    required String body,
  }) async {
    Map<String, dynamic> data = {
      "userID": userID,
      "id": id,
      "title": title,
      "body": body,
    };

    try {
      await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: jsonEncode(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editPost({
    required int userID,
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      final response = await _dio.put(
        'https://jsonplaceholder.typicode.com/posts/$id',
        data: jsonEncode(
          <String, dynamic>{
            'userID': userID,
            'id': id,
            'title': title,
            'body': body,
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
