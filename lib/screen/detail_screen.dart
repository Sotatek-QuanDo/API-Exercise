import 'package:api_call_test/class/post_description.dart';
import 'package:flutter/material.dart';

import 'package:api_call_test/class/DioClient.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _userIDController = TextEditingController();

  final TextEditingController _idController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  var _isEnabled = false;

  var _isEditing = false;
  DioClient client = DioClient();

  onChangePost(int userID, int id, String title, String body) async {
    client.editPost(
        userID: userID, id: id, title: title, body: body, context: context);
    setState(() {
      // Disable editing
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    client.getPostDescription(widget.id).then((postDescription) {
      _userIDController.text = postDescription.userId.toString();
      _idController.text = postDescription.id.toString();
      _titleController.text = postDescription.title;
      _bodyController.text = postDescription.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Screen'),
          actions: [
            ElevatedButton(
              onPressed: () {
                client.deleteUser(id: widget.id.toString(), context: context);
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
                    TextField(
                      controller: _userIDController,
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'User ID'),
                    ),
                    TextField(
                      controller: _idController,
                      enabled: _isEditing,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'ID'),
                    ),
                    TextField(
                      controller: _titleController,
                      enabled: _isEditing,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _bodyController,
                      enabled: _isEditing,
                      decoration: const InputDecoration(labelText: 'Body'),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Enable editing
                              _isEditing = true;
                              _isEnabled = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Edit'),
                        ),
                        Visibility(
                          visible: _isEnabled,
                          child: ElevatedButton(
                            onPressed: () {
                              onChangePost(
                                int.parse(_userIDController.text),
                                int.parse(_idController.text),
                                _titleController.text,
                                _bodyController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
