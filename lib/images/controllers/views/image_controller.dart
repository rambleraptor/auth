import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/aegis_models.dart';

class ImageFileController extends ChangeNotifier {
  AegisIcon? _icon;

  void findPath(String issuer) {
    _jsonFile().then((root) {
      AegisIcon? icon = root.findIssuer(issuer);
      if (icon != null) {
        _icon = icon;
      }
      notifyListeners();
    });
  }

  Future<AegisIconRoot> _jsonFile() async {
    final String response =
        await rootBundle.loadString('assets/aegis-icons/pack.json');
    final data = await json.decode(response);
    return AegisIconRoot.fromJson(data);
  }

  String path() {
    if (_icon != null) {
      return _icon!.path();
    }
    return "";
  }
}
