import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'sign-in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign-up.dart';
import 'firebase_options.dart';
import 'profile-new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          child: TopPage(),
        ),
      ),
      GoRoute(
        path: '/sign-in',
        pageBuilder: (context, state) => MaterialPage(
          child: SignIn(),
        ),
      ),
      GoRoute(
        path: '/sign-up',
        pageBuilder: (context, state) => MaterialPage(
          child: SignUp(),
        ),
      ),
      GoRoute(
        path: '/profile/new',
        pageBuilder: (context, state) => MaterialPage(
          child: ProfileNew(),
        ),
      ),
    ],
    errorPageBuilder: (_, state) => MaterialPage(
      key: state.pageKey,
      child: const ErrorPage(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'teamist',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(
                onPressed: () => context.push('/sign-in'),
                child: const Text('ログイン'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => context.push('/sign-up'),
                child: const Text('アカウント作成'),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
