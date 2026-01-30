import 'package:flutter/material.dart';

class CustomOrderPage extends StatelessWidget {
  const CustomOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '定制单',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
