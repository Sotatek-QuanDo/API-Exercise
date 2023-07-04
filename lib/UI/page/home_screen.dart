import 'package:api_call_test/data/repositories/postData.dart';
import 'package:api_call_test/logic/data_bloc/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_call_test/UI/widget/postItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostData postData = PostData();

  void navigateAddScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/add');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Call Test'),
        actions: [
          IconButton(
            onPressed: () {
              navigateAddScreen(context);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {
          if (state is DataLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Load the data succesfully',
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DataInitial) {
            return const Center(child: Text('Initial'));
          } else if (state is DataLoading) {
            return const Center(child: Text('Loading'));
          } else if (state is DataLoaded) {
            return Column(children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return PostItem(post: state.post[index]);
                },
                itemCount: state.post.length,
              )),
            ]);
          }
          return Container();
        },
      ),
    );
  }
}
