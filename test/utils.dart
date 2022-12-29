import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/account_seed.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestAccountFetcher extends AbstractAccountController {
  TestAccountFetcher({required this.accounts});
  final List<SavedAccount> accounts;
  int counter = 0;

  @override
  Future init() async {
    return;
  }

  @override
  ValueListenable accountListener() {
    return ValueNotifier(null);
  }

  @override
  List<SavedAccount> getAccounts() {
    return accounts;
  }

  @override
  void addAccount(Account account) {
    counter += 1;
    accounts.add(createSavedAccount(account, counter.toString()));
  }

  @override
  SavedAccount getAccount(int index) {
    return accounts[index];
  }

  @override
  void deleteAccount(SavedAccount account) {
    accounts.remove(account);
  }

  @override
  void updateAccount(SavedAccount account, MutableAccount newValues) {
    accounts[int.parse(account.id)] =
        createSavedAccount(createAccountFromMutable(newValues), account.id);
  }

  @override
  void incrementTapped(SavedAccount account) {
    accounts[int.parse(account.id)].incrementTapped();
  }
}

List<SavedAccount> fetchSavedAccounts(int length) {
  List<Account> accounts = fetchAccounts(length);
  return saveAllAccounts(accounts);
}

List<SavedAccount> saveAllAccounts(List<Account> accounts) {
  List<SavedAccount> savedAccounts = [];
  for (int i = 0; i < accounts.length; i++) {
    savedAccounts.add(createSavedAccount(accounts[i], i.toString()));
  }
  return savedAccounts;
}

Widget createWidget(Key key, Widget widget) {
  return ProviderScope(
    child: MaterialApp(
      title: key.toString(),
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}
