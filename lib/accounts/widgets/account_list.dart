import 'package:flutter/material.dart';

import '../models/account_fetcher.dart';
import 'account_list_item.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fetcher.getAccounts(context).length,
      itemBuilder: (context, index) {
        return AccountListItem(
            account: fetcher.getAccount(context, index),
            stream: fetcher.stream);
      },
    );
  }
}
