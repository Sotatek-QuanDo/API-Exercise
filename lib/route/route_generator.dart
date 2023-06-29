import 'package:api_call_test/screen/add_screen.dart';
import 'package:api_call_test/screen/detail_screen.dart';
import 'package:api_call_test/screen/edit_screen.dart';
import 'package:api_call_test/screen/home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);
      case '/detail':
        if (args is int) {
          return MaterialPageRoute(
              builder: (context) => DetailScreen(id: args), settings: settings);
        } else {
          return MaterialPageRoute(
              builder: (context) => const HomeScreen(), settings: settings);
        }
      case '/edit':
        if (args is int) {
          return MaterialPageRoute(
              builder: (context) => EditScreen(id: args), settings: settings);
        } else {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      case '/add':
        return MaterialPageRoute(
            builder: (context) => AddScreen(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
