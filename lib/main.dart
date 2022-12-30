import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:flutter/material.dart';

import 'app/views/app.dart';

void main() async {
  AccountController controller = AccountController();
  await controller.init();
  runApp(
    AuthApp(
      controller: controller,
    ),
  );
}
