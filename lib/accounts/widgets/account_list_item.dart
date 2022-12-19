import 'package:auth/accounts/controllers/image_controller.dart';
import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/accounts.dart';
import 'package:auth/accounts/view/new_account_view.dart';
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

class ActionListTileEditAction extends StatelessWidget {
  const ActionListTileEditAction(
      {super.key, required this.account, required this.controller});

  final SavedAccount account;
  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      key: ValueKey("${account.id}_delete_button"),
      onPressed: (context) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              NewManualAccountScreen(fetcher: controller, account: account),
        ));
      },
      backgroundColor: Colors.grey,
      icon: Icons.edit,
      label: 'Edit',
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile(
      {super.key,
      required this.account,
      required this.controller,
      required this.imageController});

  final SavedAccount account;
  final AbstractAccountController controller;
  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey("${account.id}_slidable"),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        ActionListTileEditAction(account: account, controller: controller),
        ActionListTileDeleteAction(account: account, controller: controller)
      ]),
      child: ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: imageController.widgetForWebsite(account.website),
        ),
        title: _AccountDetails(
          account: account,
        ),
        trailing: TimeRemainingWidget(
          time: account.timeRemaining(),
        ),
      ),
    );
  }
}

class _AccountDetails extends StatelessWidget {
  const _AccountDetails({required this.account});

  final Account account;

  @override
  Widget build(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            account.website,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Text(
            account.username,
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Text(
            account.code(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ],
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
          account: widget.account,
          controller: widget.controller,
          imageController: ImageFileController(),
        );
      },
    );
  }
}
