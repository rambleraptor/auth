import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/account_creation.dart';
import 'package:auth/accounts/widgets/account_list.dart';
import 'package:auth/app/controllers/tabs.dart';
import 'package:auth/app/widgets/app_bar.dart';
import 'package:auth/app/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthAppTabController extends ConsumerStatefulWidget {
  const AuthAppTabController({super.key, required this.controller});

  final AbstractAccountController controller;

  @override
  AuthAppTabControllerState createState() => AuthAppTabControllerState();
}

class AuthAppTabControllerState extends ConsumerState<AuthAppTabController> {
  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(tabProvider);
    return Scaffold(
      appBar: AuthAppBar(
        fetcher: widget.controller,
      ),
      body: AuthAppViewController(controller: widget.controller, tabType: tab),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ],
          onTap: (value) =>
              ref.read(tabProvider.notifier).switchTabWithIndex(value)),
    );
  }
}

class AuthAppViewController extends StatelessWidget {
  const AuthAppViewController(
      {super.key, required this.controller, required this.tabType});

  final AbstractAccountController controller;
  final TabType tabType;

  @override
  Widget build(BuildContext context) {
    switch (tabType) {
      case TabType.accountView:
        return AccountsList(fetcher: controller);
      case TabType.settings:
        return const SettingsPage();
      case TabType.creation:
        return AccountCreationScreen(controller: controller);
    }
  }
}
