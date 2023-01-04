import 'package:auth/password/controllers/data/password_controller.dart';
import 'package:auth/password/controllers/views/password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordForm extends ConsumerStatefulWidget {
  const PasswordForm({super.key, required this.controller});

  final PasswordController controller;

  @override
  ConsumerState<PasswordForm> createState() => PasswordFormState();
}

class PasswordFormState extends ConsumerState<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _password = "";

  final _viewModel = PasswordFormViewController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: TextFormField(
              key: const Key('password_form_field'),
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              onSaved: (password) {
                _password = password!;
              },
              validator: mustNotBeEmpty,
            ),
          ),
          TextButton(
              child: const Text('Submit'),
              onPressed: () {
                final form = _formKey.currentState;
                if (form!.validate()) {
                  form.save();
                  _viewModel.onSave(_formKey, widget.controller, _password);
                }
              })
        ],
      ),
    );
  }
}

String? mustNotBeEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return "Must not be Empty";
  }
  return null;
}
