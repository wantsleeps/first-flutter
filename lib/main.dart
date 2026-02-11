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
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark, // dark text for status bar
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
        scaffoldBackgroundColor:
            Colors.transparent, // Important for GlassScaffold
        fontFamily: 'SF Pro Display', // Use the font defined in styles
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: AppTextStyles.header,
          iconTheme: IconThemeData(color: AppColors.textBlack),
        ),
      ),
      // Use Consumer to decide which page to show
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.isLoggedIn
              ? const MyHomePage(title: '游戏陪玩')
              : const LoginPage();
        },
      ),
      // initialRoute is replaced by logic in 'home' property
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
      extendBody: true, // Allow body to go behind the floating nav
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: LiquidBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
