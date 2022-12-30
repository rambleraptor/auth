import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return AccountsList(
      fetcher: fetcher,
    );
  }
}
