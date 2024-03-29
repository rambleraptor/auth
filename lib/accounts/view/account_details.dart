import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/account_details.dart';
import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  AccountDetailsScreen(
      {super.key, required this.fetcher, this.account, this.mutableAccount});

  final AbstractAccountController fetcher;
  final SavedAccount? account;
  MutableAccount? mutableAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Account"),
      ),
      body: AccountDetailsForm(
        fetcher: fetcher,
        account: account,
        mutableAccount: mutableAccount,
      ),
    );
  }
}
