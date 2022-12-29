import 'package:auth/accounts/models/accounts.dart';

List<SavedAccount> findAccounts(String query, List<SavedAccount> accounts) {
  return accounts
      .where((account) => accountMatchesQuery(query, account))
      .toList();
}

bool accountMatchesQuery(String query, Account account) {
  return account.username.contains(query) || account.issuer.contains(query);
}
