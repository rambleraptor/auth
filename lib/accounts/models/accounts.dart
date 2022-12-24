import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:otp/otp.dart';

part 'accounts.g.dart';

@HiveType(typeId: 0)
class SavedAccount extends Account {
  SavedAccount(
      {required this.id,
      required this.secret,
      required this.issuer,
      required this.username})
      : super(secret: secret, issuer: issuer, username: username) {
    createdAt = DateTime.now();
  }

  @HiveField(0)
  final String id;

  @HiveField(1)
  @override
  // ignore: overridden_fields
  final String secret;

  @HiveField(2)
  @override
  // ignore: overridden_fields
  final String issuer;

  @HiveField(3)
  @override
  // ignore: overridden_fields
  final String username;

  @HiveField(4)
  late final DateTime createdAt;

  @HiveField(5)
  int tapped = 0;

  @override
  List<Object> get props => [id];

  void incrementTapped() {
    tapped += 1;
  }
}

class Account extends Equatable {
  const Account(
      {required this.secret, required this.issuer, required this.username});

  final String secret;

  final String issuer;

  final String username;

  @override
  List<Object> get props => [secret, issuer, username];

  String code() {
    return OTP
        .generateTOTPCode(secret, DateTime.now().millisecondsSinceEpoch)
        .toString();
  }

  int timeRemaining() {
    return OTP.remainingSeconds();
  }

  void updateCode() {
    code();
  }
}

// MutableAccounts live only in memory.
// They're used for forms, where the values can be changed by the user multiple times.
class MutableAccount {
  MutableAccount({this.secret = "", this.issuer = "", this.username = ""});

  String? secret;

  String? issuer;

  String? username;

  bool isValid() {
    return secret != "" && issuer != "" && username != "";
  }
}
