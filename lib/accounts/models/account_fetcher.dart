import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'accounts_provider.dart';

abstract class AbstractAccountController {
  void init();

  Iterable<Account> getAccounts(BuildContext context);
  Account getAccount(BuildContext context, int index);
  void addAccount(BuildContext context, Account account);

  Stream<dynamic> get stream;
}

class AccountController extends AbstractAccountController {
  AccountController({required this.stream});

  @override
  final Stream stream;

  @override
  void init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AccountAdapter());
    await Hive.openBox<Account>('accounts');
  }

  Box<Account> _box() {
    return Hive.box('accounts');
  }

  AccountsProvider _getProvider(BuildContext context) {
    return Provider.of<AccountsProvider>(context, listen: false);
  }

  @override
  Iterable<Account> getAccounts(BuildContext context) {
    var accounts = _box().values;
    return accounts.cast<Account>();
  }

  @override
  Account getAccount(BuildContext context, int index) {
    return _box().getAt(index)!;
  }

  @override
  void addAccount(BuildContext context, Account account) {
    var numAccounts = _box().values.length;
    String id = (numAccounts + 1).toString();
    _box().put(id, account);
  }
}
