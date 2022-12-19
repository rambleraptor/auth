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
  testWidgets('AccountList displays account', (tester) async {
    // Create app
    const numAccounts = 5;
    var fetcher = TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
    const testKey = Key('K');
    await tester.pumpWidget(createWidget(testKey, fetcher, null));

    // Fill out screen.
    await tester.enterText(find.byKey(const Key('secret_form_field')), 'temp');
    await tester.enterText(find.byKey(const Key('website_form_field')), 'temp');
    await tester.enterText(
        find.byKey(const Key('username_form_field')), 'temp');

    await tester.tap(find.text('Submit'));

    expect(fetcher.accounts.length, numAccounts + 1);
  });
}
