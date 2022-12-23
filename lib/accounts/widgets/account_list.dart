import 'package:auth/accounts/models/accounts.dart';
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
        return AccountsListView(
          accounts: fetcher.getAccounts().toList(),
          stream: fetcher.stream,
          controller: fetcher,
        );
      },
    );
  }
}

class AccountsListView extends StatelessWidget {
  const AccountsListView(
      {super.key,
      required this.accounts,
      required this.stream,
      required this.controller});

  final List<SavedAccount> accounts;
  final Stream<dynamic> stream;
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountListItem(
          account: accounts[index],
          stream: controller.stream,
          controller: controller,
        );
      },
    );
  }
}
