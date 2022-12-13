import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'accounts_provider.dart';

abstract class AccountFetcher {
  List<Account> getAccounts(BuildContext context);
  void addAccount(BuildContext context, Account account);
  Stream<dynamic> getStream(BuildContext context);
}

class AccountProviderFetcher extends AccountFetcher {
  AccountProviderFetcher();

  AccountsProvider _getProvider(BuildContext context) {
    return Provider.of<AccountsProvider>(context, listen: false);
  }

  @override
  List<Account> getAccounts(BuildContext context) {
    return _getProvider(context).accounts;
  }

  @override
  void addAccount(BuildContext context, Account account) {
    _getProvider(context).addAccount(account);
  }

  @override
  Stream<dynamic> getStream(BuildContext context) {
    return _getProvider(context).stream;
  }
}
