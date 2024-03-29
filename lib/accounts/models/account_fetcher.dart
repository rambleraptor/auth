import 'dart:developer';

import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'account_seed.dart';

abstract class AbstractAccountController {
  Future init();
  ValueListenable accountListener();

  Iterable<SavedAccount> getAccounts();
  SavedAccount getAccount(int index);
  void addAccount(Account account);
  void deleteAccount(SavedAccount account);
  void updateAccount(SavedAccount account, MutableAccount newValues);
  void incrementTapped(SavedAccount account);
}

class AccountController extends AbstractAccountController {
  AccountController();

  @override
  Future init() async {
    Hive.registerAdapter(SavedAccountAdapter());
    await Hive.deleteBoxFromDisk('accounts');
    await Hive.openBox<SavedAccount>('accounts');

    if (kDebugMode) {
      // Delete box to avoid spillover.
      await Hive.openBox<SavedAccount>('accounts');
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
    var uuid = const Uuid();
    String id = uuid.v4();
    SavedAccount savedAccount = createSavedAccount(account, id);
    log("Adding account $savedAccount with id $id");
    _box().put(id, savedAccount);
  }

  @override
  void deleteAccount(SavedAccount account) {
    _box().delete(account.id);
  }

  @override
  void updateAccount(SavedAccount account, MutableAccount newValues) {
    Account newAccount = createAccountFromMutable(newValues);
    SavedAccount newSavedAccount = createSavedAccount(newAccount, account.id);
    log("Updating account ${account.id}");
    _box().put(account.id, newSavedAccount);
  }

  @override
  void incrementTapped(SavedAccount account) {
    account.incrementTapped();
    _box().put(account.id, account);
  }
}

// This does not save an account!
// It's really a private method needed to take an unsaved account + attach an id to it.
SavedAccount createSavedAccount(Account account, String id) {
  return SavedAccount(
      id: id,
      secret: account.secret,
      issuer: account.issuer,
      username: account.username);
}

Account createAccountFromMutable(MutableAccount newAccount) {
  if (!newAccount.isValid()) {
    throw ("Cannot create account from invalid mutable account");
  }
  return Account(
      secret: newAccount.secret!,
      username: newAccount.username!,
      issuer: newAccount.issuer!);
}

void getOrCreateAccount(SavedAccount? account, MutableAccount newAccount,
    AbstractAccountController controller) {
  if (account == null) {
    Account immutableAccount = createAccountFromMutable(newAccount);
    controller.addAccount(immutableAccount);
    return;
  }
  controller.updateAccount(account, newAccount);
}
