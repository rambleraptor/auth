import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';

class AccountSearchDelegate extends SearchDelegate {
  AbstractAccountController? controller;
  Stream<dynamic>? stream;

  AccountSearchDelegate({required this.controller, required this.stream})
      : super();

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
        accounts: filteredAccounts, stream: stream!, controller: controller!);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

List<SavedAccount> findAccounts(String query, List<SavedAccount> accounts) {
  return accounts
      .where((account) => accountMatchesQuery(query, account))
      .toList();
}

bool accountMatchesQuery(String query, Account account) {
  return account.username.contains(query) || account.website.contains(query);
}
