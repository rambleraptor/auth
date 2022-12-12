import 'package:auth/accounts/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

MaterialApp createWidget(Key key, int time) {
  return MaterialApp(
    title: key.toString(),
    home: Scaffold(
      body: TimeRemainingWidget(key: key, time: time),
    ),
  );
}

void main() {
  testWidgets('TimeRemainingWidget shows time remaining in green',
      (tester) async {
    const testKey = Key('K');
    await tester.pumpWidget(createWidget(testKey, 30));

    final timeTextFinder = find.text('30');
    expect(timeTextFinder, findsOneWidget);
  });
}
