import 'package:auth/accounts/view/account_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends MaterialApp {
  const AuthApp({super.key}) : super(home: const AccountsPage());
}
