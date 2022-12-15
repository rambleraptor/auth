import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/account_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'accounts/models/accounts.dart';
import 'accounts/models/accounts_provider.dart';

void main() async {
  runApp(
    AuthApp(
      controller: AccountController(
        stream: Stream.periodic(Duration(seconds: 1)).asBroadcastStream(),
      ),
    ),
  );
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountsPage(
        fetcher: controller,
      ),
    );
  }
}
