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
        title: const Text("Second Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the Second Page!",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
              child: const Text("Go Back"),
            ),
            ElevatedButton(
              onPressed: () => go(context),
              child: const Text("Go to Test Page"),
            ),
          ],
        ),
      ),
    );
  }
}
