import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/test.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future<void> go(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Test()),
    );
    if (result == 'refresh') {
      print('refresh');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情页"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("这里是详情页！", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
              child: const Text("返回"),
            ),
            ElevatedButton(
              onPressed: () => go(context),
              child: const Text("前往测试页"),
            ),
          ],
        ),
      ),
    );
  }
}
