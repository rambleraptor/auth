import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';

class AccountManualForm extends StatefulWidget {
  const AccountManualForm({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  State<AccountManualForm> createState() => _AccountManualFormState();
}

class _AccountManualFormState extends State<AccountManualForm> {
  final _formKey = GlobalKey<FormState>();
  var contents = {};

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            key: const Key('secret_form_field'),
            decoration: const InputDecoration(
              labelText: "Secret",
            ),
            onSaved: (secret) {
              contents['secret'] = secret;
            },
            validator: mustNotBeEmpty,
          ),
          TextFormField(
            key: const Key('website_form_field'),
            decoration: const InputDecoration(
              labelText: "Website",
            ),
            validator: mustNotBeEmpty,
            onSaved: (website) {
              contents['website'] = website;
            },
          ),
          TextFormField(
            key: const Key('username_form_field'),
            decoration: const InputDecoration(
              labelText: "Username",
            ),
            validator: mustNotBeEmpty,
            onSaved: (username) {
              contents['username'] = username;
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              final form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                Account account = Account(
                    secret: contents['secret'],
                    username: contents['username'],
                    website: contents['website']);
                widget.fetcher.addAccount(account);
                Navigator.pop(context);
              }
            },
          )
        ]));
  }
}

String? mustNotBeEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return "Must not be Empty";
  }
  return null;
}
