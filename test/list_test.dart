import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  testWidgets('AccountList swipable will delete accounts', (tester) async {
    const numAccounts = 5;
    var fetcher = TestAccountFetcher(
      accounts: fetchSavedAccounts(numAccounts),
    );
    var account = fetcher.getAccount(0);
    const testKey = Key('K');
    const gestureDetectorKey = ValueKey('gesture_detector');
    const endActionPaneKey = ValueKey('end');

    // Mostly stolen from https://github.com/letsar/flutter_slidable/blob/master/test/slidable_test.dart
    await tester.pumpWidget(MaterialApp(
      title: testKey.toString(),
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Slidable(
            endActionPane: ActionPane(
              key: endActionPaneKey,
              motion: const ScrollMotion(),
              children: [
                ActionListTileDeleteAction(
                    account: account, controller: fetcher)
              ],
            ),
            child: Builder(builder: (context) {
              return GestureDetector(
                key: gestureDetectorKey,
                onTap: () {
                  Slidable.of(context)!.openEndActionPane();
                },
              );
            }),
          ),
        ),
      ),
    ));

    await tester.tap(find.byKey(gestureDetectorKey));
    await tester.pumpAndSettle();

    expect(find.byKey(endActionPaneKey), findsOneWidget);

    var deleteFinder = find.byKey(Key("${account.id}_delete_button"));
    expect(deleteFinder, findsOneWidget);
    await tester.tap(deleteFinder);

    expect(fetcher.getAccounts().length, numAccounts - 1);
  });
}
