import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

Widget widget(Key key, AbstractAccountController af) {
  return createWidget(
    key,
    AccountsList(key: key, fetcher: af),
  );
}

void main() {
  testWidgets('AccountList displays accounts', (tester) async {
    const numAccounts = 5;
    const testKey = Key('K');
    await tester.runAsync(
      () => tester.pumpWidget(
        widget(
          testKey,
          TestAccountFetcher(
            accounts: fetchSavedAccounts(numAccounts),
          ),
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

  testWidgets('AccountList will copy to clipboard', (tester) async {
    const numAccounts = 1;
    const testKey = Key('K');
    var fetcher = TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
    await tester.runAsync(
      () => tester.pumpWidget(
        widget(
          testKey,
          fetcher,
        ),
      ),
    );

    await tester.tap(find.byType(AccountListItem));
    expect(fetcher.getAccount(0).tapped, 1);
    Clipboard.getData("text/plain")
        .then((value) => expect(value!.text, fetcher.getAccount(0).code()));
  });
}
