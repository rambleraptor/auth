import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/view/account_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

MaterialApp createWidget(
    Key key, AbstractAccountController af, SavedAccount? account) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: AccountDetailsScreen(
        key: key,
        fetcher: af,
        account: account,
      ),
    ),
  );
}

void main() {
  group('AccountDetailsPage', () {
    testWidgets('AccountList displays account after form fill', (tester) async {
      // Create app
      const numAccounts = 5;
      var fetcher =
          TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
      const testKey = Key('K');
      await tester.pumpWidget(createWidget(testKey, fetcher, null));

      // Fill out screen.
      await tester.enterText(
          find.byKey(const Key('secret_form_field')), 'temp');
      await tester.enterText(
          find.byKey(const Key('website_form_field')), 'temp');
      await tester.enterText(
          find.byKey(const Key('username_form_field')), 'temp');

      await tester.tap(find.text('Submit'));

      expect(fetcher.accounts.length, numAccounts + 1);
    });

    testWidgets('Details Page shows values with account', (tester) async {
      // Create app
      const numAccounts = 5;
      var fetcher =
          TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
      const testKey = Key('K');
      await tester.pumpWidget(createWidget(testKey, fetcher, null));

      // Recreate page with account
      SavedAccount account = fetcher.getAccount(0);
      await tester.pumpWidget(createWidget(testKey, fetcher, account));

      var finder = find.byType(TextFormField);
      var items = finder.evaluate().toList();

      expect(items.length, 3);
      expect((items[0].widget as TextFormField).initialValue, account.secret);
      expect((items[1].widget as TextFormField).initialValue, account.website);
      expect((items[2].widget as TextFormField).initialValue, account.username);
    });

    testWidgets('Details Page shows no values without account', (tester) async {
      // Create app
      const numAccounts = 5;
      var fetcher =
          TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
      const testKey = Key('K');
      await tester.pumpWidget(createWidget(testKey, fetcher, null));

      var finder = find.byType(TextFormField);
      var items = finder.evaluate().toList();

      expect(items.length, 3);
      expect((items[0].widget as TextFormField).initialValue, "");
      expect((items[1].widget as TextFormField).initialValue, "");
      expect((items[2].widget as TextFormField).initialValue, "");
    });

    testWidgets('AccountDetails page updates account', (tester) async {
      // Create app
      const numAccounts = 5;
      var fetcher =
          TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
      const testKey = Key('K');
      SavedAccount account = fetcher.getAccount(1);
      await tester.pumpWidget(createWidget(testKey, fetcher, account));

      const newSecret = 'temp';

      // Fill out screen.
      await tester.enterText(
          find.byKey(const Key('secret_form_field')), newSecret);

      await tester.tap(find.text('Submit'));

      // Account numbers should be same since accounts are the same.
      expect(fetcher.accounts.length, numAccounts);

      SavedAccount accountAgain = fetcher.getAccount(int.parse(account.id));
      expect(accountAgain.secret, newSecret);
    });
  });
}
