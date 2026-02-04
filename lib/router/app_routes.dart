import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/wallet_page.dart';
import '../pages/order_list_page.dart';
import '../pages/second_page.dart';
import '../pages/test.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String wallet = '/wallet';
  static const String orders = '/orders';
  static const String details = '/details';
  static const String test = '/test';

  static Map<String, WidgetBuilder> get routes => {
    // home: (context) => MyHomePage(title: '游戏陪玩', token: 10), // Conflict with MaterialApp.home
    login: (context) => const LoginPage(),
    wallet: (context) => const WalletPage(),
    orders: (context) => const OrderListPage(),
    details: (context) => const SecondPage(), // Keeping existing
    test: (context) => const Test(),
  };
}
