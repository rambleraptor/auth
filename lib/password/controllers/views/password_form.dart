import 'package:auth/password/controllers/data/password_controller.dart';
import 'package:flutter/material.dart';

class PasswordFormViewController {
  void onSave(GlobalKey<FormState> formKey, PasswordController controller,
      String password) {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      controller.setPassword(password);
    }
  }
}
