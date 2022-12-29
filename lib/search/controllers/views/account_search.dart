import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';

import '../data/search.dart';

class AccountSearchDelegate extends SearchDelegate {
  AbstractAccountController? controller;

  AccountSearchDelegate({required this.controller}) : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SavedAccount> accounts = controller!.getAccounts().toList();
    List<SavedAccount> filteredAccounts = findAccounts(query, accounts);
    return AccountsListView(
        accounts: filteredAccounts, controller: controller!);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SavedAccount> accounts = controller!.getAccounts().toList();
    List<SavedAccount> filteredAccounts = findAccounts(query, accounts);
    return AccountsListView(
        accounts: filteredAccounts, controller: controller!);
  }
}
