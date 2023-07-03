import 'package:flutter/material.dart';
import 'package:api_call_test/data/models/post.dart';
import 'package:api_call_test/UI/page/detail_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  void onClickedPost(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailScreen(
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          onClickedPost(context, post.id!);
        },
        child: ListTile(
          title: Text(
            'Title: ${post.title}',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Text(
                'ID: ${post.id}',
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'User ID: ${post.userId}',
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Body:',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '${post.body}',
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
