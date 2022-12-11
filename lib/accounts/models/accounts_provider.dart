import 'package:flutter/material.dart';

import 'accounts.dart';

class AccountsProvider extends ChangeNotifier {
  AccountsProvider(this.accounts, this.stream);

  List<Account> accounts;

  // AccountProvider subscribes to the stream to know when to refresh codes.
  // Streams should provide events every second.
  Stream<dynamic> stream;

  void addAccount(Account account) {
    accounts.add(account);
    notifyListeners();
  }
}
