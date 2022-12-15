import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestAccountFetcher extends AbstractAccountController {
  TestAccountFetcher({required this.accounts});
  final List<Account> accounts;

  @override
  Future init() async {
    return;
  }

  @override
  ValueListenable accountListener() {
    return ValueNotifier(null);
  }

  @override
  List<Account> getAccounts(BuildContext context) {
    return accounts;
  }

  @override
  void addAccount(Account account) {
    accounts.add(account);
  }

  @override
  Account getAccount(BuildContext context, int index) {
    return accounts[index];
  }

  @override
  Stream<dynamic> get stream {
    return const Stream.empty().asBroadcastStream();
  }
}
