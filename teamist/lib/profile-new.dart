import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileNew extends StatefulWidget {
  const ProfileNew({Key? key}) : super(key: key);

  @override
  State<ProfileNew> createState() => _ProfileNewState();
}

class _ProfileNewState extends State<ProfileNew> {
  final auth = FirebaseAuth.instance;
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィールを作成'),
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return CancelSignUp();
                });
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${auth.currentUser?.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            Text(
              'EMAIL: ${auth.currentUser?.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            auth.currentUser!.emailVerified
                ? Text(
                    'メールアドレス認証済み',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'メールアドレスが認証されていません',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
            ElevatedButton(
              onPressed: () {
                auth.currentUser!.sendEmailVerification();
              },
              child: Text('確認メールを送信'),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                if (auth.currentUser?.uid != null) {
                  context.go('/profile/new');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CancelSignUp extends StatelessWidget {
  CancelSignUp({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('アカウント作成の取り消し'),
      content: Text('戻るとアカウント作成が取り消されます。よろしいですか？'),
      actions: <Widget>[
        GestureDetector(
          child: Text('キャンセル'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: Text('はい'),
          onTap: () async {
            await auth.currentUser?.delete();
            context.go('/');
          },
        )
      ],
    );
  }
}