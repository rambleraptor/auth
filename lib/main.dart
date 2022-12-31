import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/views/app.dart';

void main() async {
  await Hive.initFlutter();

  AccountController controller = AccountController();
  await controller.init();
  runApp(
    AuthApp(
      controller: controller,
    ),
  );
}
