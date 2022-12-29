import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/account_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  AccountController controller = AccountController();
  await controller.init();
  runApp(
    ProviderScope(
      child: AuthApp(
        controller: controller,
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
