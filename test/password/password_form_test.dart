import 'package:auth/password/controllers/data/password_controller.dart';
import 'package:auth/password/widgets/password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

MaterialApp createWidget(Key key, PasswordController controller) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: PasswordForm(
        key: key,
        controller: controller,
      ),
    ),
  );
}

void main() {
  group('PasswordForm', () {
    testWidgets('Password should be settable', (tester) async {
      // Create app
      var fetcher = TestPasswordController();
      var passwordValue = 'temp';
      const testKey = Key('K');

      expect(fetcher.usesPassword(), false);
      await tester.pumpWidget(createWidget(testKey, fetcher));

      // Fill out screen.
      await tester.enterText(
          find.byKey(const Key('password_form_field')), passwordValue);

      await tester.tap(find.text('Submit'));

      expect(fetcher.usesPassword(), true);
      expect(fetcher.matches(passwordValue), true);
      expect(fetcher.matches('badPassword'), false);
    });
  });
}
