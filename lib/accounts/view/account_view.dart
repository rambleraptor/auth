import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/view/new_account_view.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Accounts')),
        body: AccountsList(accounts: fetchAccounts(10)),
        floatingActionButton: FloatingActionButton(
            onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewManualAccountScreen(),
                  ))
                },
            child: const Icon(Icons.add_rounded)));
  }
}
