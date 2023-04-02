import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アカウント作成'),
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
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(infoText),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final User? user = (await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _password))
                              .user;
                          if (user != null) 
                            context.push('/profile/new');
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            final snackBar = SnackBar(
                              content: Text("登録に失敗しました: エラーコード「${e.code}」"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                      child: const Text('アカウント作成')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
