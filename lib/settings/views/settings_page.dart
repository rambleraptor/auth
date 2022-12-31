import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(
            Icons.lock,
          ),
          title: TextFormField(
            key: const Key("password_form_field"),
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
