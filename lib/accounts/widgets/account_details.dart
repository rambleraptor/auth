import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/view_models/account_details.dart';
import 'package:flutter/material.dart';

class AccountDetailsForm extends StatefulWidget {
  const AccountDetailsForm(
      {super.key, required this.fetcher, this.account, this.mutableAccount});

  final AbstractAccountController fetcher;
  final SavedAccount? account;
  final MutableAccount? mutableAccount;

  @override
  State<AccountDetailsForm> createState() => _AccountDetailsFormState();
}

class _AccountDetailsFormState extends State<AccountDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.mutableAccount != null) {
      updatedAccount = widget.mutableAccount!;
    }
  }

  // Stores form contents that have not been saved.
  // Will be empty for existing accounts, but non-null for creation from QR code.
  MutableAccount updatedAccount = MutableAccount();

  final AccountDetailsViewModel _viewModel = AccountDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: TextFormField(
              key: const Key('secret_form_field'),
              initialValue: _viewModel.initialSecretValue(
                  widget.account, widget.mutableAccount),
              decoration: const InputDecoration(
                labelText: "Secret",
              ),
              onSaved: (secret) {
                updatedAccount.secret = secret;
              },
              validator: mustNotBeEmpty,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: TextFormField(
              key: const Key('issuer_form_field'),
              initialValue: _viewModel.initialIssuerValue(
                  widget.account, widget.mutableAccount),
              decoration: const InputDecoration(
                labelText: "Issuer",
              ),
              validator: mustNotBeEmpty,
              onSaved: (issuer) {
                updatedAccount.issuer = issuer;
              },
            ),
          ),
          ListTile(
              leading: const Icon(Icons.account_circle),
              title: TextFormField(
                key: const Key('username_form_field'),
                initialValue: _viewModel.initialUsernameValue(
                    widget.account, widget.mutableAccount),
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
                validator: mustNotBeEmpty,
                onSaved: (username) {
                  updatedAccount.username = username;
                },
              )),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              final form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                getOrCreateAccount(
                    widget.account, updatedAccount, widget.fetcher);
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
