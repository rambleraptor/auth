import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';

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
  Stream<dynamic> get stream {
    return const Stream.empty().asBroadcastStream();
  }

  @override
  void deleteAccount(SavedAccount account) {
    accounts.remove(account);
  }
}

List<SavedAccount> fetchSavedAccounts(int length) {
  List<Account> accounts = fetchAccounts(length);
  List<SavedAccount> savedAccounts = [];
  for (int i = 0; i < length; i++) {
    savedAccounts.add(createSavedAccount(accounts[i], i.toString()));
  }
  return savedAccounts;
}
