import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/search/controllers/data/filers.dart';
import 'package:auth/search/controllers/views/account_search.dart';
import 'package:auth/accounts/view/account_creation.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/search/controllers/views/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        AuthAppBarSearchButton(controller: fetcher),
        const AuthAppBarFilterButton(),
      ],
    );
  }

  @override
  // ignore: prefer_const_constructors
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AuthAppBarSearchButton extends StatelessWidget {
  AuthAppBarSearchButton({super.key, required this.controller});

  final AbstractAccountController controller;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.search,
      ),
      onPressed: () {
        showSearch(
          context: context,
          delegate: AccountSearchDelegate(controller: controller),
        );
      },
    );
  }
}

class AuthAppBarFilterButton extends ConsumerWidget {
  const AuthAppBarFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton(
      items: const <DropdownMenuItem>[
        DropdownMenuItem(
          value: FilterType.username,
          child: Text("Username"),
        ),
        DropdownMenuItem(
          value: FilterType.website,
          child: Text("Username"),
        ),
        DropdownMenuItem(
          value: FilterType.mostCommon,
          child: Text("Most Commonly Used"),
        ),
      ],
      onChanged: (value) => ref
          .read<FilterTypeNotifier>(filtersProvider.notifier)
          .changeFilter(value),
    );
  }
}
