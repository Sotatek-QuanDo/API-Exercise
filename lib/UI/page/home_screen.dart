import 'package:flutter/material.dart';

import 'package:api_call_test/UI/widget/postItem.dart';
import 'package:api_call_test/models/post/post.dart';
import 'package:api_call_test/Services/base_client/dio_client.dart';

class HomeScreen extends StatelessWidget {
  List<Post> postList = [];
  DioClient client = DioClient();

  HomeScreen({super.key});

  void navigateAddScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Call Test'),
        actions: [
          IconButton(
            onPressed: () {
              navigateAddScreen(context);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: client.getPostData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return PostItem(post: snapshot.data![index]);
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
