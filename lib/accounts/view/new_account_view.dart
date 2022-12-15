import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/widgets/account_creation_form.dart';
import 'package:flutter/material.dart';

class NewManualAccountScreen extends StatelessWidget {
  const NewManualAccountScreen({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Account"),
      ),
      body: AccountManualForm(
        fetcher: fetcher,
      ),
    );
  }
}
