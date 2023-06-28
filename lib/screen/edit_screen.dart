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
  int id = 0;
  String title = "";
  String body = "";

  final GlobalKey<FormState> _formKey = GlobalKey();

  DioClient client = DioClient();

  onChangePost(int userID, int id, String title, String body) async {
    client.editPost(
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
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
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
                          keyboardType: TextInputType.number,
                          initialValue: snapshot.data!.id.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter some text";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            id = int.parse(value!);
                          },
                          decoration: const InputDecoration(labelText: 'ID'),
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
                                id,
                                title,
                                body,
                              );
                            }

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
