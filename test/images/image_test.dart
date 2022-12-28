import 'package:auth/images/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
          AccountImage(
            account: controller.getAccount(0),
          ),
        ),
      );

      var items = find.byType(AccountImage);
      expect(items.evaluate().length, 1);
    });
  });
}
