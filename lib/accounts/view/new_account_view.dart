import 'package:auth/accounts/widgets/account_creation_form.dart';
import 'package:flutter/material.dart';

class NewManualAccountScreen extends StatelessWidget {
  const NewManualAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Account"),
      ),
      body: const AccountManualForm(),
    );
  }
}
