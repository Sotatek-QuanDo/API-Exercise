import 'package:api_call_test/logic/data_bloc/data_bloc.dart';
import 'package:api_call_test/logic/detail_bloc/detail_bloc.dart';
import 'package:api_call_test/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataCubit(),
        ),
        BlocProvider(
          create: (context) => DetailCubit(),
        ),
      ],
      child: const MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
