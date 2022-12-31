import 'package:hive_flutter/hive_flutter.dart';

part 'password_info.g.dart';

@HiveType(typeId: 1)
class PasswordInfo {
  PasswordInfo({required this.hasPassword, required this.passwordHash});

  @HiveField(0)
  bool hasPassword;

  @HiveField(1)
  String passwordHash;
}
