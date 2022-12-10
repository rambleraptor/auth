import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/models/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var provider = Provider.of<AccountsProvider>(context);
    return ListView.builder(
        itemCount: provider.accounts.length,
        itemBuilder: (context, index) {
          return AccountListItemWithProvider(
              account: provider.accounts[index], stream: _stream);
        });
  }
}
