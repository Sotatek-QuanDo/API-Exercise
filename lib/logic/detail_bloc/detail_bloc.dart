import 'package:api_call_test/data/dataproviders/dio_client.dart';
import 'package:api_call_test/data/repositories/postData.dart';
import 'package:api_call_test/data/models/post.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());
  final PostData postDetail = PostData();
  final DioClient _dio = DioClient();

  void getPostDetail(int id) async {
    try {
      emit(DetailLoading());
      final postDescription = await postDetail.getPostDescriptionData(id);
      emit(DetailLoaded(post: postDescription));
    } on DioError catch (e) {
      throw e;
    }
  }

  void deletePost(int id) async {
    try {
      emit(DetailDeleting());
      await _dio.deleteUser(id: id.toString());
      emit(DetailDeleted());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editPost(int userID, int id, String title, String body) async {
    try {
      emit(DetailEditing());
      await _dio.editPost(userID: userID, id: id, title: title, body: body);
      emit(DetailEdited());
    } catch (e) {
      rethrow;
    }
  }
}
