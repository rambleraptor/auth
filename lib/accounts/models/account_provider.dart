import 'package:flutter/material.dart';

import 'accounts.dart';

class AccountProvider extends ChangeNotifier {
  final Account account;
  AccountProvider(this.account);

  void updateCode() {
    account.code();
    notifyListeners();
  }
}
