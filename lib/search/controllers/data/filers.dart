import 'package:auth/accounts/models/accounts.dart';

enum FilterType {
  website,
  username,
  mostCommon,
}

List<SavedAccount> filterAccounts(
    List<SavedAccount> accounts, FilterType filterType) {
  switch (filterType) {
    case FilterType.username:
      {
        accounts.sort((a, b) => a.username.compareTo(b.username));
      }
      break;

    case FilterType.website:
      {
        accounts.sort((a, b) => a.issuer.compareTo(b.issuer));
      }
      break;

    case FilterType.mostCommon:
      {
        accounts.sort((a, b) => a.tapped.compareTo(b.tapped));
      }
      break;
  }
  return accounts;
}
