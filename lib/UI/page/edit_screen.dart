import 'package:api_call_test/data/dataproviders/dio_client.dart';
import 'package:api_call_test/data/repositories/postData.dart';
import 'package:api_call_test/logic/detail_bloc/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  PostData postData = PostData();
  DetailCubit _detailCubit = DetailCubit();

  @override
  void initState() {
    _detailCubit.getPostDetail(widget.id);
    super.initState();
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
        body: BlocProvider.value(
          value: _detailCubit,
          child: BlocListener<DetailCubit, DetailState>(
            listener: (context, state) {
              if (state is DetailEdited) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/detail', (route) => route.isFirst,
                    arguments: widget.id);
              }
            },
            child: BlocBuilder<DetailCubit, DetailState>(
                builder: (context, state) {
              if (state is DetailLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              } else if (state is DetailLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: state.post.userId.toString(),
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
                          initialValue: state.post.title,
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
                          initialValue: state.post.body,
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
                              _detailCubit.editPost(
                                userID,
                                widget.id,
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
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}
