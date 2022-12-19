import 'dart:developer';

import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'account_seed.dart';

abstract class AbstractAccountController {
  Future init();
  ValueListenable accountListener();

  Iterable<SavedAccount> getAccounts();
  SavedAccount getAccount(int index);
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
    await Hive.deleteBoxFromDisk('accounts');
    await Hive.openBox<SavedAccount>('accounts');

    if (kDebugMode) {
      // Delete box to avoid spillover.
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
  Iterable<SavedAccount> getAccounts() {
    var accounts = _box().values;
    return accounts.cast<SavedAccount>();
  }

  @override
  SavedAccount getAccount(int index) {
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

SavedAccount createSavedAccount(Account account, String id) {
  return SavedAccount(
      id: id,
      secret: account.secret,
      website: account.website,
      username: account.username);
}
