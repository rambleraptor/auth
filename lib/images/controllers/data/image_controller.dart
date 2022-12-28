import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/aegis_models.dart';

class ImageFileController extends ChangeNotifier {
  @override
  Future<String> pathForIssuer(String issuer) {
    return jsonFile().then((root) {
      AegisIcon? icon = root.findIssuer(issuer);
      if (icon != null) {
        return icon.path();
      }
      return "";
    });
  }

  Future<AegisIconRoot> jsonFile() async {
    final String response =
        await rootBundle.loadString('assets/aegis-icons/pack.json');
    final data = await json.decode(response);
    return AegisIconRoot.fromJson(data);
  }
}
