import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home_page.dart';
import 'pages/message_page.dart';
import 'pages/profile_page.dart';
import 'router/app_routes.dart';
import 'widgets/glass_scaffold.dart';
import 'utils/style.dart';

import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'providers/user_provider.dart';
import 'widgets/liquid_bottom_nav_bar.dart'; // Import

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 状态栏透明
      statusBarIconBrightness: Brightness.dark, // 状态栏文字深色
    ),
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '游戏陪玩',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent, // 对 GlassScaffold 很重要
        fontFamily: 'SF Pro Display', // 使用样式中定义的字体
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: AppTextStyles.header,
          iconTheme: IconThemeData(color: AppColors.textBlack),
        ),
      ),
      // 使用 Consumer 决定显示哪个页面
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.isLoggedIn
              ? const MyHomePage(title: '游戏陪玩')
              : const LoginPage();
        },
      ),
      // initialRoute 被 'home' 属性中的逻辑取代
      routes: AppRoutes.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.token});

  final String title;
  final int? token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
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
    return GlassScaffold(
      extendBody: true, // 允许 body 内容延伸到浮动导航栏下方
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: LiquidBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
