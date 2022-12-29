import 'package:auth/search/controllers/data/search.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  test('Search Accounts tests', () {
    var accounts = [
      // A search on Facebook should ignore.
      const Account(secret: "facebook", issuer: "fidelity", username: "test"),
      // A search on fide should get this and full fidelity.
      const Account(secret: "facebook", issuer: "fide", username: "test"),
      // A search on facebook should only fetch this.
      const Account(secret: "fidelity", issuer: "facebook", username: "test"),
      // A search on "my-user" should only fetch this one.
      const Account(secret: "fidelity", issuer: "google", username: "my-user"),
    ];

    List<SavedAccount> savedAccounts = saveAllAccounts(accounts);

    expect(findAccounts("fide", savedAccounts).length, 2);
    expect(findAccounts("facebook", savedAccounts).length, 1);
    expect(findAccounts("my-user", savedAccounts).length, 1);
  });
}
