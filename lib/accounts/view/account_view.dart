import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/new_account_view.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key, required this.fetcher});

  final AccountFetcher fetcher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: AccountsList(
        fetcher: fetcher,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewManualAccountScreen(fetcher: fetcher),
            ),
          )
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
