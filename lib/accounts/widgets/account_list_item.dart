import 'package:flutter/material.dart';
import 'package:auth/accounts/accounts.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(account.website),
        isThreeLine: true,
        subtitle: Text(account.username),
        dense: true,
      ),
    );
  }
}
