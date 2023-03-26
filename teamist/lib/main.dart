import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'top.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teamist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      name: 'top',
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const TopPage(),
      ),
    ),
  ]);
}