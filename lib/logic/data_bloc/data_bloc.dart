import 'package:api_call_test/data/dataproviders/dio_client.dart';
import 'package:api_call_test/data/models/post.dart';
import 'package:api_call_test/data/repositories/postData.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataLoading());
  final DioClient _dio = DioClient();
  final PostData _postData = PostData();

  void getPostList() async {
    try {
      final postList = await _postData.getPostData();
      emit(DataLoaded(postList));
    } on DioError catch (e) {
      throw e;
    }
  }

  void submitForm(int userID, int id, String title, String body) async {
    try {
      await _dio.addNewPost(userID: userID, id: id, title: title, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
