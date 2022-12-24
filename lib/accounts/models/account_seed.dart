import 'dart:math';

import 'package:english_words/english_words.dart';

import 'accounts.dart';

List<String> issuers = [
  "Facebook",
  "Google",
  "GitHub",
  "Apple",
  "Box",
  "Fastly",
];

List<Account> fetchAccounts(int length) {
  List<Account> list = [];
  nouns.take(length).forEach((element) {
    final random = Random();
    String issuer = issuers[random.nextInt(issuers.length)];
    list.add(Account(secret: element, issuer: issuer, username: element));
  });
  return list;
}
