import 'package:flutter/material.dart';
import 'webview_page.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("错误")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("错误"),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("返回"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("返回"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("返回"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("返回"),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: const Text("错误"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("返回"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewPage(
                      url: 'http://192.168.200.33:8080/inv/',
                    ),
                  ),
                );
              },
              child: const Text("跳转到 H5"),
            ),
          ],
        ),
      ),
    );
  }
}
