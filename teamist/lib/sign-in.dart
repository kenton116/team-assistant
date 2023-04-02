import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メールアドレスが入力されていません!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードが入力されていません!';
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        labelText: 'パスワード',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    onChanged: (String value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                          child: const Text('ログイン'),
                          onPressed: () async {
                            try {
                              final User? user = (await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _email, password: _password))
                                  .user;
                              if (user != null) context.go('/team/join');
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                final snackBar = SnackBar(
                                  content:
                                      Text("ログインに失敗しました: ${e.code}"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }
                          }),
                      ElevatedButton(
                          child: const Text('パスワードリセット'),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: _email);
                              setState(() {
                                final snackBar = SnackBar(
                                  content:
                                    Text("パスワードリセット用のメールを送信しました"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                final snackBar = SnackBar(
                                  content:
                                    Text("メールの送信に失敗しました：${e.code}"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
