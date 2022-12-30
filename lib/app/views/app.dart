import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/app/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key, required this.controller});
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Accounts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthAppTabController(
          controller: controller,
        ),
      ),
    );
  }
}
