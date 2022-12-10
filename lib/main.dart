import 'package:auth/accounts/view/account_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'accounts/models/accounts.dart';
import 'accounts/models/accounts_provider.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountsProvider>(
        create: (context) => AccountsProvider(fetchAccounts(10)),
        child: Consumer<AccountsProvider>(
            builder: (context, accountsProvider, child) => MaterialApp(
                  title: 'Accounts',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: const AccountsPage(),
                )));
  }
}
