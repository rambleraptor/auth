import 'package:auth/accounts/models/account_provider.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(account.website),
        isThreeLine: true,
        subtitle: Text(account.code()),
        trailing: TimeRemainingWidget(time: account.timeRemaining()),
        dense: true,
      ),
    );
  }
}

class AccountListItemWithStream extends StatefulWidget {
  const AccountListItemWithStream(
      {super.key, required this.account, required this.stream});

  final Account account;
  final Stream stream;

  @override
  State<AccountListItemWithStream> createState() =>
      _AccountListItemWithStream();
}

class _AccountListItemWithStream extends State<AccountListItemWithStream> {
  void initState() {
    super.initState();
    widget.stream.forEach((element) {
      Provider.of<AccountProvider>(context, listen: false)..updateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountProvider>(
        create: (context) => AccountProvider(widget.account),
        child: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) =>
                AccountListTile(account: accountProvider.account)));
  }
}

class AccountListItem extends StatelessWidget {
  const AccountListItem(
      {super.key, required this.account, required this.stream});

  final Account account;
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountProvider>(
        create: (context) => AccountProvider(account),
        child: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) =>
                AccountListItemWithStream(
                    account: accountProvider.account, stream: stream)));
  }
}
