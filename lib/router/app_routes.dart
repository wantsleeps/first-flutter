import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/wallet_page.dart';
import '../pages/order_list_page.dart';
import '../pages/second_page.dart';
import '../pages/test.dart';
import '../pages/error.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String wallet = '/wallet';
  static const String orders = '/orders';
  static const String details = '/details';
  static const String test = '/test';
  static const String error = '/error';

  static Map<String, WidgetBuilder> get routes => {
    // home: (context) => MyHomePage(title: '游戏陪玩', token: 10), // 与 MaterialApp.home 冲突
    login: (context) => const LoginPage(),
    wallet: (context) => const WalletPage(),
    orders: (context) => const OrderListPage(),
    details: (context) => const SecondPage(), // 保留现有
    test: (context) => const Test(),
    error: (context) => const ErrorPage(),
  };
}
