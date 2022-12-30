import 'dart:developer';

import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:auth/accounts/view_models/account_creation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AccountCreationScreen extends StatelessWidget {
  AccountCreationScreen({super.key, required this.controller});

  final AbstractAccountController controller;
  final AccountCreationViewModel _viewModel = AccountCreationViewModel();

  Widget debugButton(BuildContext context) {
    if (kDebugMode) {
      return ElevatedButton(
          child: const Text("Debug Mode: Add Account"),
          onPressed: () => _viewModel.onBarcodeValueFetched(context, controller,
              "otpauth://totp/Google%3Aexample%40gmail.com?secret=37ov6moffivvpcyrcmy5muxf5segf4lf&issuer=Google"));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        SizedBox(
          height: 300,
          child: MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String totpUrl = barcode.rawValue!;
                log('Barcode found! $totpUrl');
                _viewModel.onBarcodeValueFetched(context, controller, totpUrl);
              }
            },
          ),
        ),
        ElevatedButton(
          onPressed: () =>
              _viewModel.onManualAccountCreation(context, controller),
          child: const Text("Add Account Manually"),
        ),
        debugButton(context),
      ],
    );
  }
}
