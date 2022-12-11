import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';
import 'package:otp/otp.dart';

class Account extends Equatable {
  const Account(
      {required this.secret, required this.website, required this.username});
  final String secret;
  final String website;
  final String username;

  @override
  List<Object> get props => [secret, website, username];

  String code() {
    return OTP
        .generateTOTPCode(secret, DateTime.now().millisecondsSinceEpoch)
        .toString();
  }

  int timeRemaining() {
    return OTP.remainingSeconds();
  }
}

List<Account> fetchAccounts(int length) {
  List<Account> list = [];
  nouns.take(length).forEach((element) {
    list.add(
        Account(secret: element, website: "website", username: "username"));
  });
  return list;
}
