import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/app/controllers/tabs.dart';
import 'package:auth/search/controllers/data/filers.dart';
import 'package:auth/search/controllers/views/account_search.dart';
import 'package:auth/search/controllers/views/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthAppBar extends ConsumerWidget with PreferredSizeWidget {
  const AuthAppBar({super.key, required this.fetcher});

  final AbstractAccountController fetcher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(tabProvider);
    return AppBar(
      title: Text(
        appBarTitle(tabType),
      ),
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
  const AuthAppBarSearchButton({super.key, required this.controller});

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
    return PopupMenuButton<FilterType>(
      icon: const Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterType>>[
        const PopupMenuItem(
          value: FilterType.username,
          child: Text("Username"),
        ),
        const PopupMenuItem(
          value: FilterType.website,
          child: Text("Website"),
        ),
        const PopupMenuItem(
          value: FilterType.mostCommon,
          child: Text("Most Commonly Used"),
        ),
      ],
      onSelected: (FilterType value) => ref
          .read<FilterTypeNotifier>(filtersProvider.notifier)
          .changeFilter(value),
    );
  }
}
