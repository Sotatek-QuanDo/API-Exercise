import 'package:api_call_test/class/DioClient.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final int id;
  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _userIDController = TextEditingController();

  final TextEditingController _idController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _bodyController = TextEditingController();

  DioClient client = DioClient();

  onChangePost(int userID, int id, String title, String body) async {
    client.editPost(
        userID: userID, id: id, title: title, body: body, context: context);
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
        title: Text(
          _titleController.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
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
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
