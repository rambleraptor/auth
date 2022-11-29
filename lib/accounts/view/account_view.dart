import 'package:auth/accounts/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/accounts/accounts.dart';
import 'package:auth/accounts/widgets/account_list_item.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Accounts')),
        body: BlocProvider(
          create: (_) => AccountBloc()..add(AccountFetched()),
          child: const AccountsList(),
        ));
  }
}

class AccountsList extends StatefulWidget {
  const AccountsList({super.key});

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      switch (state.status) {
        case AccountStatus.failure:
          return const Center(child: Text('failed to fetch accounts'));
        case AccountStatus.success:
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            return AccountListItem(account: state.accounts[index]);
          });
      }
    });
  }
}
