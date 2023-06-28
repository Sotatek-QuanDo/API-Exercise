import 'package:api_call_test/route/route_generator.dart';
import 'package:api_call_test/screen/detail_screen.dart';
import 'package:api_call_test/screen/edit_screen.dart';
import 'package:api_call_test/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
