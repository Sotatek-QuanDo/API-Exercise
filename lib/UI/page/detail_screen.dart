import 'package:api_call_test/data/repositories/postData.dart';
import 'package:flutter/material.dart';

import 'package:api_call_test/data/dataproviders/dio_client.dart';
import 'package:api_call_test/logic/detail_bloc/detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DetailCubit _detailCubid = DetailCubit();

  DioClient client = DioClient();

  PostData postData = PostData();

  void navigateEditScreen(int? id, BuildContext context) {
    Navigator.of(context).pushNamed(
      '/edit',
      arguments: id,
    );
  }

  @override
  void initState() {
    _detailCubid.getPostDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _detailCubid,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Screen'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _detailCubid.deletePost(widget.id);
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
        body: BlocListener<DetailCubit, DetailState>(
          listener: (context, state) {
            if (state is DetailDeleting) {
              Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text(
                      'Data Deleting',
                    ),
                  ],
                ),
              );
            }
            if (state is DetailDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Deleting completed',
                  ),
                ),
              );
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          child: BlocBuilder<DetailCubit, DetailState>(
            builder: (context, state) {
              if (state is DetailInitial) {
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text(
                        'Data Initializing',
                      ),
                    ],
                  ),
                );
              } else if (state is DetailLoading) {
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text(
                        'Data Loading',
                      ),
                    ],
                  ),
                );
              } else if (state is DetailLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User ID: ${state.post.userId}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'ID: ${state.post.id}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Title:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${state.post.title})',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Body:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${state.post.body})',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            navigateEditScreen(state.post.id, context);
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
