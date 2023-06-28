import 'package:api_call_test/class/DioClient.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final int id;
  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  int userID = 0;
  String title = "";
  String body = "";

  final _formKey = GlobalKey<FormState>();

  DioClient client = DioClient();

  onChangePost(int userID, int id, String title, String body) async {
    try {
      await client.editPost(userID: userID, id: id, title: title, body: body);
      var snackBar = const SnackBar(
        content: Text(
          'Edit post succesfully',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      var snackBar = const SnackBar(
        content: Text(
          'Edit post failed',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void navigateDetailScreen() async {
    await Navigator.of(context).pushNamed('/detail', arguments: widget.id);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Post ID: ${widget.id}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: snapshot.data!.userId.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userID = int.parse(value!);
                          },
                          decoration:
                              const InputDecoration(labelText: 'User ID'),
                        ),
                        TextFormField(
                          initialValue: snapshot.data!.title,
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
                          initialValue: snapshot.data!.body,
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
                              onChangePost(
                                userID,
                                widget.id,
                                title,
                                body,
                              );
                            }
                            navigateDetailScreen();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
