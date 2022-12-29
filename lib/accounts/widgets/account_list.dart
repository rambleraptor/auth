import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/search/controllers/data/filers.dart';
import 'package:auth/search/controllers/views/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account_fetcher.dart';
import 'account_list_item.dart';

class AccountsList extends ConsumerWidget {
  const AccountsList({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterType = ref.watch(filtersProvider);

    return ValueListenableBuilder(
      valueListenable: fetcher.accountListener(),
      builder: (context, value, child) {
        return AccountsListView(
          accounts: filterAccounts(fetcher.getAccounts().toList(), filterType),
          controller: fetcher,
        );
      },
    );
  }
}

class AccountsListView extends StatelessWidget {
  const AccountsListView(
      {super.key, required this.accounts, required this.controller});

  final List<SavedAccount> accounts;
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountListItem(
          account: accounts[index],
          controller: controller,
        );
      },
    );
  }
}
