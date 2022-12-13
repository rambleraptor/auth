import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/view/new_account_view.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';
import 'package:auth/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

MaterialApp createWidget(Key key, AccountFetcher af) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: NewManualAccountScreen(
        key: key,
        fetcher: af,
      ),
    ),
  );
}

void main() {
  testWidgets('AccountList displays account', (tester) async {
    // Create app
    const numAccounts = 5;
    var fetcher = TestAccountFetcher(accounts: fetchAccounts(numAccounts));
    const testKey = Key('K');
    await tester.pumpWidget(createWidget(testKey, fetcher));

    // Fill out screen.
    await tester.enterText(find.byKey(const Key('secret_form_field')), 'temp');
    await tester.enterText(find.byKey(const Key('website_form_field')), 'temp');
    await tester.enterText(
        find.byKey(const Key('username_form_field')), 'temp');

    await tester.tap(find.text('Submit'));

    expect(fetcher.accounts.length, numAccounts + 1);
  });
}