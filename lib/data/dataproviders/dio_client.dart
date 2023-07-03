import 'package:dio/dio.dart';
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

  Future<Response> getRawPostData() async {
    try {
      final Response postData =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      return postData;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Response> getRawPostDescription(int id) async {
    try {
      Response postDescription =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/$id');
      return postDescription;
    } on DioError catch (e) {
      rethrow;
    }
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
