import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/app/controllers/tabs.dart';
import 'package:flutter/material.dart';

import '../models/accounts.dart';

class AccountDetailsViewModel {
  String initialSecretValue(Account? account, MutableAccount? mutableAccount) {
    if (account != null) {
      return account.secret;
    }
    if (mutableAccount != null) {
      if (mutableAccount.secret != null) {
        return mutableAccount.secret!;
      }
    }
    return "";
  }

  String initialIssuerValue(Account? account, MutableAccount? mutableAccount) {
    if (account != null) {
      return account.issuer;
    }
    if (mutableAccount != null) {
      if (mutableAccount.issuer != null) {
        return mutableAccount.issuer!;
      }
    }
    return "";
  }

  String initialUsernameValue(
      Account? account, MutableAccount? mutableAccount) {
    if (account != null) {
      return account.username;
    }
    if (mutableAccount != null) {
      if (mutableAccount.username != null) {
        return mutableAccount.username!;
      }
    }
    return "";
  }

  void onSave(
      BuildContext context,
      SavedAccount? savedAccount,
      MutableAccount updatedAccount,
      AbstractAccountController fetcher,
      TabNotifier tabNotifier) {
    getOrCreateAccount(savedAccount, updatedAccount, fetcher);
    _navigateToListScreen(context, tabNotifier);
  }

  void _navigateToListScreen(BuildContext context, TabNotifier tabNotifier) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    tabNotifier.switchTab(TabType.accountView);
  }
}
