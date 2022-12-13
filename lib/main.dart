import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/account_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'accounts/models/accounts.dart';
import 'accounts/models/accounts_provider.dart';

void main() {
  runApp(AuthAppWithProvider());
}

class AuthAppWithProvider extends StatelessWidget {
  const AuthAppWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountsProvider>(
      create: (context) => AccountsProvider(
        fetchAccounts(10),
        Stream.periodic(Duration(seconds: 1)).asBroadcastStream(),
      ),
      child: Consumer<AccountsProvider>(
        builder: (context, accountsProvider, child) => MaterialApp(
          title: 'Accounts',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AccountsPage(
            fetcher: AccountProviderFetcher(),
          ),
        ),
      ),
    );
  }
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key, required this.fetcher});
  // This widget is the root of your application.
  final AccountFetcher fetcher;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountsPage(fetcher: fetcher),
    );
  }
}
