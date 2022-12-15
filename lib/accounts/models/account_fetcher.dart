import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AbstractAccountController {
  Future init();
  ValueListenable accountListener();

  Iterable<Account> getAccounts(BuildContext context);
  Account getAccount(BuildContext context, int index);
  void addAccount(Account account);

  Stream<dynamic> get stream;
}

class AccountController extends AbstractAccountController {
  AccountController({required this.stream});

  @override
  final Stream stream;

  @override
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AccountAdapter());
    await Hive.openBox<Account>('accounts');

    if (kDebugMode) {
      fetchAccounts(10).forEach((account) {
        addAccount(account);
      });
    }
  }

  @override
  ValueListenable accountListener() {
    return _box().listenable();
  }

  Box<Account> _box() {
    return Hive.box('accounts');
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
  void addAccount(Account account) {
    var numAccounts = _box().values.length;
    String id = (numAccounts + 1).toString();
    _box().put(id, account);
  }
}
