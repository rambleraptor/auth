import 'package:auth/accounts/models/account_seed.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/images/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

MaterialApp createWidget(Key key, Account account) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: AccountImage(account: account),
    ),
  );
}

void main() {
  group('ImageFileController', () {
    testWidgets('should be able to fetch an icon without failing',
        (tester) async {
      const numAccounts = 5;
      const testKey = Key('K');
      var controller =
          TestAccountFetcher(accounts: fetchSavedAccounts(numAccounts));
      await tester.pumpWidget(
        createWidget(
          testKey,
          controller.getAccount(0),
        ),
      );

      var items = find.byType(AccountImage);
      expect(items.evaluate().length, 1);

      var svgItems = find.byType(SvgPicture);
      expect(items.evaluate().length, 1);
    });
  });
}
