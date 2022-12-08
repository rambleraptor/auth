import 'package:auth/accounts/accounts.dart';
import 'package:flutter/material.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: AccountsList(accounts: fetchAccounts(10)),
    );
  }
}

class AccountsList extends StatefulWidget {
  AccountsList({super.key, required this.accounts});

  List<Account> accounts = [];

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.accounts.length,
        itemBuilder: (context, index) {
          return AccountListItem(account: widget.accounts[index]);
        });
  }
}
