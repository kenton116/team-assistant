import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teamist"),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text("ログイン"),
        onPressed: () {
          context.goNamed("/");
        },
      )),
    );
  }
}
