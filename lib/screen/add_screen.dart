import 'package:api_call_test/class/DioClient.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _userIDController = TextEditingController();
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  DioClient client = DioClient();

  void _submitForm() {
    final userID = _userIDController.text;
    final id = _idController.text;
    final title = _titleController.text;
    final body = _bodyController.text;

    client.addNewPost(
        userID: int.parse(userID),
        id: int.parse(id),
        title: title,
        body: body,
        context: context);

    _userIDController.clear();
    _idController.clear();
    _titleController.clear();
    _bodyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userIDController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
