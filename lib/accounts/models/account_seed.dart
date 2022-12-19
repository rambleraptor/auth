import 'dart:math';

import 'package:english_words/english_words.dart';

import 'accounts.dart';

List<String> websites = [
  "www.facebook.com",
  "www.chase.com",
  "www.github.com",
  "www.cash.app",
  "www.fedex.com",
  "www.fidelity.com",
];

List<Account> fetchAccounts(int length) {
  List<Account> list = [];
  nouns.take(length).forEach((element) {
    final random = Random();
    String website = websites[random.nextInt(websites.length)];
    list.add(Account(secret: element, website: website, username: element));
  });
  return list;
}
