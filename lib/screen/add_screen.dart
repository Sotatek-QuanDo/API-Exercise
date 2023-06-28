import 'package:api_call_test/class/DioClient.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int userID = 0;
  int id = 0;
  String title = "";
  String body = "";
  final GlobalKey<FormState> _formKey = GlobalKey();

  DioClient client = DioClient();

  void _submitForm(int userID, int id, String title, String body) async {
    await client.addNewPost(
        userID: userID, id: id, title: title, body: body, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userID = int.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'User ID'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    id = int.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    body = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Body'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitForm(userID, id, title, body);
                    }
                    _formKey.currentState!.reset();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
