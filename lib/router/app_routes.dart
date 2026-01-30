import 'package:flutter/material.dart';
import '../main.dart';
import '../pages/second_page.dart';
import '../pages/test.dart';

class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  static const String test = '/test';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => MyHomePage(title: 'Flutter Demo Home Page', token: 10),
    details: (context) => const SecondPage(),
    test: (context) => const Test(),
  };
}
