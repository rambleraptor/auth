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

class AccountListItem extends StatefulWidget {
  const AccountListItem(
      {super.key, required this.account, required this.stream});

  final Account account;
  final Stream stream;

  @override
  State<AccountListItem> createState() => _AccountListItem();
}

class _AccountListItem extends State<AccountListItem> {
  @override
  void initState() {
    super.initState();
    widget.account.updateCode();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return AccountListTile(account: widget.account);
      },
    );
  }
}
