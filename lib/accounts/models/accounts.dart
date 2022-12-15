import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:otp/otp.dart';

part 'accounts.g.dart';

@HiveType(typeId: 0)
class Account extends Equatable {
  const Account(
      {required this.secret, required this.website, required this.username});

  @HiveField(0)
  final String secret;

  @HiveField(1)
  final String website;

  @HiveField(2)
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
