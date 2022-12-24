import 'dart:developer';

import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view/account_details.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key, required this.controller});

  final AbstractAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add an Account"),
        ),
        body: ListView(
          children: [
            MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  log('Barcode found! $code');
                }
              },
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AccountDetailsScreen(fetcher: controller))),
              child: const Text("Add Account Manually"),
            ),
          ],
        ));
  }
}
