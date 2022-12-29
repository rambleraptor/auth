import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/search/controllers/data/filers.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  test('test username filter', () {
    List<Account> accounts = [
      const Account(username: "c", issuer: "x", secret: "abc"),
      const Account(username: "b", issuer: "y", secret: "abc"),
      const Account(username: "a", issuer: "z", secret: "abc"),
    ];

    List<SavedAccount> savedAccounts = saveAllAccounts(accounts);

    List<SavedAccount> filteredAccounts =
        filterAccounts(savedAccounts, FilterType.username);

    expect(filteredAccounts[0].username, "a");
    expect(filteredAccounts[1].username, "b");
    expect(filteredAccounts[2].username, "c");
  });

  test('test website filter', () {
    List<Account> accounts = [
      const Account(username: "c", issuer: "z", secret: "abc"),
      const Account(username: "b", issuer: "y", secret: "abc"),
      const Account(username: "a", issuer: "x", secret: "abc"),
    ];

    List<SavedAccount> savedAccounts = saveAllAccounts(accounts);

    List<SavedAccount> filteredAccounts =
        filterAccounts(savedAccounts, FilterType.website);

    expect(filteredAccounts[0].issuer, "x");
    expect(filteredAccounts[1].issuer, "y");
    expect(filteredAccounts[2].issuer, "z");
  });

  test('test tapped filter', () {
    List<Account> accounts = [
      const Account(username: "c", issuer: "z", secret: "abc"),
      const Account(username: "b", issuer: "y", secret: "abc"),
      const Account(username: "a", issuer: "x", secret: "abc"),
    ];

    List<SavedAccount> savedAccounts = saveAllAccounts(accounts);

    List<SavedAccount> tappedAccounts = [
      incrementMultipleTimes(savedAccounts[0], 1),
      incrementMultipleTimes(savedAccounts[1], 2),
      incrementMultipleTimes(savedAccounts[2], 3),
    ];

    List<SavedAccount> filteredAccounts =
        filterAccounts(tappedAccounts, FilterType.mostCommon);

    expect(filteredAccounts[0].username, "c");
    expect(filteredAccounts[1].username, "b");
    expect(filteredAccounts[2].username, "a");
  });
}

SavedAccount incrementMultipleTimes(SavedAccount a, int times) {
  for (int i = 0; i < times; i++) {
    a.incrementTapped();
  }
  return a;
}
