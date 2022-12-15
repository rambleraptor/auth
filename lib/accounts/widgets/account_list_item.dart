import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActionListTileDeleteAction extends StatelessWidget {
  const ActionListTileDeleteAction(
      {super.key, required this.account, required this.controller});

  final SavedAccount account;
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      key: ValueKey("${account.id}_delete_button"),
      onPressed: (context) {
        controller.deleteAccount(account);
      },
      backgroundColor: Colors.red,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile(
      {super.key, required this.account, required this.controller});

  final SavedAccount account;
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey("${account.id}_slidable"),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        ActionListTileDeleteAction(account: account, controller: controller)
      ]),
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
      {super.key,
      required this.account,
      required this.stream,
      required this.controller});

  final SavedAccount account;
  final Stream stream;
  final AbstractAccountController controller;

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
        return AccountListTile(
            account: widget.account, controller: widget.controller);
      },
    );
  }
}
