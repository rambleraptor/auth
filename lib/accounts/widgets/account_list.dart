import 'package:auth/accounts/models/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account_fetcher.dart';
import 'account_list_item.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key, required this.fetcher});

  final AccountFetcher fetcher;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fetcher.getAccounts(context).length,
      itemBuilder: (context, index) {
        return AccountListItem(
            account: fetcher.getAccounts(context)[index],
            stream: fetcher.getStream(context));
      },
    );
  }
}
