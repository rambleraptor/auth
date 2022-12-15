import 'dart:developer';

import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AbstractAccountController {
  Future init();
  ValueListenable accountListener();

  Iterable<SavedAccount> getAccounts(BuildContext context);
  SavedAccount getAccount(BuildContext context, int index);
  void addAccount(Account account);
  void deleteAccount(SavedAccount account);

  Stream<dynamic> get stream;
}

class AccountController extends AbstractAccountController {
  AccountController({required this.stream});

  @override
  final Stream stream;

  @override
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SavedAccountAdapter());
    await Hive.openBox<SavedAccount>('accounts');

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

  Box<SavedAccount> _box() {
    return Hive.box('accounts');
  }

  @override
  Iterable<SavedAccount> getAccounts(BuildContext context) {
    var accounts = _box().values;
    return accounts.cast<SavedAccount>();
  }

  @override
  SavedAccount getAccount(BuildContext context, int index) {
    return _box().getAt(index)!;
  }

  @override
  void addAccount(Account account) {
    var numAccounts = _box().values.length;
    String id = (numAccounts + 1).toString();
    SavedAccount savedAccount = createSavedAccount(account, id);
    log("Adding account $savedAccount with id $id");
    _box().put(id, savedAccount);
  }

  @override
  void deleteAccount(SavedAccount account) {
    _box().delete(account.id);
  }
}
