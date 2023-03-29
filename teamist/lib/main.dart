import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'sign-in.dart';
import 'sign-up.dart';

void main() {
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
    ],
    errorPageBuilder: (_, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorPage(),
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
            Text(
              'teamist',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(
                onPressed: () => context.push('/sign-in'),
                child: Text('ログイン'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => context.push('/sign-up'),
                child: Text('アカウント作成'),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}

// class BasicPage extends StatelessWidget {
//   const BasicPage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => context.go('/'),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: Center(
//         child: sign-in(),
//       ),
//     );
//   }
// }

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
