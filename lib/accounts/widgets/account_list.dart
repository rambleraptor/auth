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
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AccountsProvider>(context);
    return ListView.builder(
        itemCount: provider.accounts.length,
        itemBuilder: (context, index) {
          return AccountListItem(
              account: provider.accounts[index], stream: provider.stream);
        });
  }
}
