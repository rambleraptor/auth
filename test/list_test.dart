import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

MaterialApp createWidget(Key key, AbstractAccountController af) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: AccountsList(
        key: key,
        fetcher: af,
      ),
    ),
  );
}

void main() {
  testWidgets('AccountList displays accounts', (tester) async {
    const numAccounts = 5;
    const testKey = Key('K');
    await tester.pumpWidget(
      createWidget(
        testKey,
        TestAccountFetcher(
          accounts: fetchSavedAccounts(numAccounts),
        ),
      ),
    );

    var items = find.byType(AccountListItem);
    expect(items.evaluate().length, numAccounts);
  });
}
