import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

MaterialApp createWidget(Key key, AccountFetcher af) {
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

// Overrides
class TestAccountFetcher extends AccountFetcher {
  TestAccountFetcher({required this.accounts});
  final List<Account> accounts;

  @override
  List<Account> getAccounts(BuildContext context) {
    return accounts;
  }

  @override
  void addAccount(BuildContext context, Account account) {
    accounts.add(account);
  }

  @override
  Stream<dynamic> getStream(BuildContext context) {
    return Stream.empty().asBroadcastStream();
  }
}

void main() {
  testWidgets('AccountList displays accounts', (tester) async {
    const numAccounts = 5;
    const testKey = Key('K');
    await tester.pumpWidget(
      createWidget(
        testKey,
        TestAccountFetcher(
          accounts: fetchAccounts(numAccounts),
        ),
      ),
    );

    var items = find.byType(AccountListItem);
    expect(items.evaluate().length, numAccounts);
  });
}
