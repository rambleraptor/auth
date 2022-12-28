import 'dart:convert';

import 'package:auth/accounts/models/accounts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/aegis_models.dart';

class ImageFileController {
  late final FutureProvider<String> provider;

  ImageFileController(Account account) {
    provider = FutureProvider<String>((ref) async {
      return findPath(account.issuer);
    });
  }

  Future<String> findPath(String issuer) {
    return _jsonFile().then((root) {
      AegisIcon? icon = root.findIssuer(issuer);
      return icon!.path();
    });
  }

  Future<AegisIconRoot> _jsonFile() async {
    final String response =
        await rootBundle.loadString('assets/aegis-icons/pack.json');
    final data = await json.decode(response);
    return AegisIconRoot.fromJson(data);
  }
}
