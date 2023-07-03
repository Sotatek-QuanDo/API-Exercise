import 'package:api_call_test/data/dataproviders/dio_client.dart';
import 'package:api_call_test/data/models/post.dart';
import 'package:dio/dio.dart';

class PostData {
  final DioClient client = DioClient();

  Future<List<Post>> getPostData() async {
    try {
      final Response postData = await client.getRawPostData();
      final List<dynamic> jsonData = postData.data;
      final List<Post> postList =
          jsonData.map((post) => Post.fromJson(post)).toList();
      return postList;
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<Post> getPostDescriptionData(int id) async {
    try {
      final Response postDescriptionData =
          await client.getRawPostDescription(id);
      final Post postDescription = Post.fromJson(postDescriptionData.data);
      print('yayyyy');
      return postDescription;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
