import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordForm extends ConsumerStatefulWidget {
  const PasswordForm({super.key});

  @override
  ConsumerState<PasswordForm> createState() => PasswordFormState();
}

class PasswordFormState extends ConsumerState<PasswordForm> {}

class PasswordFormState extends ConsumerState<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _password = "";

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
            onPressed: () => _viewModel.onSave(
                context,
                _formKey,
                widget.account,
                updatedAccount,
                widget.fetcher,
                ref.read(tabProvider.notifier)),
          )
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
