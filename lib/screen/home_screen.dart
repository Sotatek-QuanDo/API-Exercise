import 'package:api_call_test/screen/add_screen.dart';
import 'package:api_call_test/class/DioClient.dart';
import 'package:api_call_test/widget/postItem.dart';
import 'package:flutter/material.dart';
import 'package:api_call_test/class/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> postList = [];
  DioClient client = DioClient();

  void navigateAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddScreen(),
      ),
    );
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
