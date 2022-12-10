import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/accounts_provider.dart';

class AccountManualForm extends StatefulWidget {
  const AccountManualForm({super.key});

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
            decoration: const InputDecoration(
              labelText: "Secret",
            ),
            onSaved: (secret) {
              contents['secret'] = secret;
            },
            validator: mustNotBeEmpty,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Website",
            ),
            validator: mustNotBeEmpty,
            onSaved: (website) {
              contents['website'] = website;
            },
          ),
          TextFormField(
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
                Provider.of<AccountsProvider>(context, listen: false)
                    .addAccount(Account(
                        secret: contents['secret'],
                        username: contents['username'],
                        website: contents['website']));
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
