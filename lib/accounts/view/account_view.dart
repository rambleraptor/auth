import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/models/account_search.dart';
import 'package:auth/accounts/view/account_creation.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        fetcher: fetcher,
      ),
      body: AccountsList(
        fetcher: fetcher,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AccountCreationScreen(controller: fetcher),
            ),
          )
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class AuthAppBar extends StatelessWidget with PreferredSizeWidget {
  const AuthAppBar({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Accounts'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: AccountSearchDelegate(
                  controller: fetcher, stream: fetcher.stream),
            );
          },
        )
      ],
    );
  }

  @override
  // ignore: prefer_const_constructors
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
