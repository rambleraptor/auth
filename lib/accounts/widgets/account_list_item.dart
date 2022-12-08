import 'package:flutter/material.dart';
import 'package:auth/accounts/accounts.dart';
import 'package:provider/provider.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(account.website),
        isThreeLine: true,
        subtitle: Text(account.code()),
        trailing: Text(account.timeRemaining()),
        dense: true,
      ),
    );
  }
}

class AccountListItemWithProvider extends StatelessWidget {
  const AccountListItemWithProvider({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountProvider>(
        create: (context) => AccountProvider(account),
        child: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) =>
                AccountListItem(account: accountProvider.account)));
  }
}
