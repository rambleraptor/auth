import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';

import 'account_list_item.dart';

class AccountsList extends StatefulWidget {
  AccountsList({super.key, required this.accounts});

  List<Account> accounts = [];

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  final Stream _stream =
      Stream.periodic(Duration(seconds: 1)).asBroadcastStream();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.accounts.length,
        itemBuilder: (context, index) {
          return AccountListItemWithProvider(
              account: widget.accounts[index], stream: _stream);
        });
  }
}
