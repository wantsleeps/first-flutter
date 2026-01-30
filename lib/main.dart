import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/club_page.dart';
import 'package:hello_flutter/pages/custom_order_page.dart';
import 'package:hello_flutter/pages/home_page.dart';
import 'package:hello_flutter/pages/message_page.dart';
import 'package:hello_flutter/pages/profile_page.dart';

import 'router/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 这个组件是应用程序的根组件。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, this.token});

  final String title;

  int? token = 0;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ClubPage(),
    CustomOrderPage(),
    MessagePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次调用 setState 时都会重新运行此方法，例如上面的 _incrementCounter 方法所做的操作。
    //
    // Flutter 框架经过优化，可以快速重新运行 build 方法，因此你可以直接重建任何需要更新的内容，
    // 而无需单独更改组件实例。

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: '俱乐部'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '定制单'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // 大于3个选项时必须设置这个，否则会变成白色无法看见
        onTap: _onItemTapped,
      ),
    );
  }
}
