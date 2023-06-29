import 'package:flutter/material.dart';

import 'package:api_call_test/Services/base_client/dio_client.dart';

class DetailScreen extends StatelessWidget {
  final int id;

  DetailScreen({super.key, required this.id});

  DioClient client = DioClient();
  void navigateEditScreen(int? id, BuildContext context) {
    Navigator.of(context).pushNamed(
      '/edit',
      arguments: id,
    );
  }

  void deletePost(int id, BuildContext context) {
    try {
      client.deleteUser(id: id.toString());
      const snackBar = SnackBar(
        content: Text(
          'Delete a post succesfully',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.popUntil(context, (route) => route.settings.name == '/home');
    } catch (e) {
      const snackBar = SnackBar(
        content: Text(
          'Delete a post failed',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        actions: [
          ElevatedButton(
            onPressed: () {
              deletePost(id, context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Set the background color to red
            ),
            child: const Text(
              'Delete',
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: client.getPostDescription(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ID: ${snapshot.data!.userId}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'ID: ${snapshot.data!.id}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Title:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '(${snapshot.data!.title})',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Body:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '(${snapshot.data!.body})',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateEditScreen(snapshot.data!.id, context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue,
                        ),
                      ),
                      child: const Text(
                        'Edit',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
