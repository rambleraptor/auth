import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';

class TestAccountFetcher extends AccountFetcher {
  TestAccountFetcher({required this.accounts});
  final List<Account> accounts;

  @override
  List<Account> getAccounts(BuildContext context) {
    return accounts;
  }

  @override
  void addAccount(BuildContext context, Account account) {
    accounts.add(account);
  }

  @override
  Stream<dynamic> getStream(BuildContext context) {
    return Stream.empty().asBroadcastStream();
  }
}
