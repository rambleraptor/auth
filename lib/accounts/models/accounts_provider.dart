import 'package:flutter/material.dart';

import 'accounts.dart';

class AccountsProvider extends ChangeNotifier {
  AccountsProvider(this.accounts);
  List<Account> accounts;

  void addAccount(Account account) {
    accounts.add(account);
    notifyListeners();
  }
}
