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
}
