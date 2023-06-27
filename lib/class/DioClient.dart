import 'dart:convert';

import 'package:api_call_test/class/post.dart';
import 'package:api_call_test/class/post_description.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio _dio = Dio();

  Future<void> deleteUser({
    required String id,
    required BuildContext context,
  }) async {
    const snackBar = SnackBar(
      content: Text(
        'Delete succesfully',
      ),
    );
    try {
      await _dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print('Error deleting user: $e');
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
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
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
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return description;
  }

  Future<void> addNewPost({
    required int userID,
    required int id,
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    const snackBar = SnackBar(
      content: Text(
        'Add a new post succesfully',
      ),
    );
    Map<String, dynamic> data = {
      "userID": userID,
      "id": id,
      "title": title,
      "body": body,
    };

    try {
      Response response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: jsonEncode(data),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print('Error new post: $e');
    }
  }

  Future<void> editPost({
    required int userID,
    required int id,
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    const snackBar = SnackBar(
      content: Text(
        'Edit post succesfully',
      ),
    );
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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }
}
