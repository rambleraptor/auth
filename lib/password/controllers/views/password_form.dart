import 'package:auth/password/controllers/data/password_controller.dart';
import 'package:flutter/material.dart';

class PasswordFormViewController {
  void onSave(GlobalKey<FormState> formKey, PasswordController controller,
      String password) {
    controller.setPassword(password);
  }
}
