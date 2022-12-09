import 'package:flutter/material.dart';
import 'package:auth/accounts/accounts.dart';
import 'package:provider/provider.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(account.website),
        isThreeLine: true,
        subtitle: Text(account.code()),
        trailing: Text(account.timeRemaining()),
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
      print("Printing inside stream");
      Provider.of<AccountProvider>(context, listen: false)..updateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountProvider>(
        create: (context) => AccountProvider(widget.account),
        child: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) =>
                AccountListItem(account: accountProvider.account)));
  }
}

class AccountListItemWithProvider extends StatelessWidget {
  const AccountListItemWithProvider(
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
