import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account(
      {required this.secret, required this.website, required this.username});
  final String secret;
  final String website;
  final String username;

  @override
  List<Object> get props => [secret, website, username];
}

List<Account> fetchAccounts(int length) {
  List<Account> list = [];
  nouns.take(length).forEach((element) {
    list.add(
        Account(secret: element, website: "website", username: "username"));
  });
  return list;
}
