import 'package:api_call_test/screen/edit_screen.dart';
import 'package:api_call_test/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:api_call_test/class/DioClient.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DioClient client = DioClient();
  void navigateEditScreen(int id) {
    Navigator.of(context).pushNamed(
      '/edit',
      arguments: id,
    );
  }

  void deletePost(int id) {
    try {
      client.deleteUser(id: widget.id.toString());
      const snackBar = SnackBar(
        content: Text(
          'Delete a post succesfully',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.popUntil(context, (route) => route.settings.name == '/');
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
              deletePost(widget.id);
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
        future: client.getPostDescription(widget.id),
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
                    snapshot.data!.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Body:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    snapshot.data!.body,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateEditScreen(
                          snapshot.data!.id,
                        );
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
