import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:otp/otp.dart';

part 'accounts.g.dart';

@HiveType(typeId: 0)
class SavedAccount extends Account {
  SavedAccount(
      {required this.id,
      required this.secret,
      required this.website,
      required this.username})
      : super(secret: secret, website: website, username: username) {
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
  final String website;

  @HiveField(3)
  @override
  // ignore: overridden_fields
  final String username;

  @HiveField(4)
  late DateTime createdAt;

  @override
  List<Object> get props => [id];
}

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

  void updateCode() {
    code();
  }
}
