import 'package:auth/password/models/password_info.dart';
import 'package:crypt/crypt.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PasswordController {
  Future init();

  PasswordInfo getInfo();

  void setInfo(PasswordInfo info);

  void setPassword(String password) {
    final hash = Crypt.sha256(password).toString();
    PasswordInfo passwordInfo =
        PasswordInfo(hasPassword: true, passwordHash: hash);
    setInfo(passwordInfo);
  }

  // Defines if this vault is password protected.
  bool usesPassword() {
    return getInfo().hasPassword;
  }

  // Returns true if attempt matches the password being used.
  bool matches(String attempt) {
    PasswordInfo info = getInfo();
    final h = Crypt(info.passwordHash);
    return h.match(attempt);
  }
}

// A Password Controller that stores the hashed passwords inside Hive.
class PasswordControllerHiveImpl extends PasswordController {
  String passwordKey = '0';
  String box = 'password_info';

  @override
  Future init() async {
    Hive.registerAdapter(PasswordInfoAdapter());
    await Hive.openBox<PasswordInfo>('password_info');
  }

  @override
  PasswordInfo getInfo() {
    return Hive.box(box).get(passwordKey);
  }

  @override
  void setInfo(PasswordInfo info) {
    Hive.box(box).put(passwordKey, info);
  }
}
