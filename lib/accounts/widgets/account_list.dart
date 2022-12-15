import 'package:flutter/material.dart';

import '../models/account_fetcher.dart';
import 'account_list_item.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: fetcher.accountListener(),
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: fetcher.getAccounts().length,
          itemBuilder: (context, index) {
            return AccountListItem(
              account: fetcher.getAccount(index),
              stream: fetcher.stream,
              controller: fetcher,
            );
          },
        );
      },
    );
  }
}
