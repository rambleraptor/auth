import 'package:auth/accounts/models/account_fetcher.dart';
import 'package:flutter/material.dart';

import '../models/url_parser.dart';
import '../view/account_details.dart';

class AccountCreationViewModel {
  void onBarcodeValueFetched(BuildContext context,
      AbstractAccountController controller, String totpUrl) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccountDetailsScreen(
              fetcher: controller,
              mutableAccount: parseTOTPString(totpUrl),
            )));
  }

  void onManualAccountCreation(
      BuildContext context, AbstractAccountController controller) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccountDetailsScreen(fetcher: controller)));
  }
}
