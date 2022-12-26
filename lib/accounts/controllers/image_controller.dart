import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_controller.g.dart';

abstract class ImageController {
  // pathForIssuer returns the path to an image file for a given issuer.
  // It returns a Future because loading the image name may require async actions.
  Future<String> pathForIssuer(String issuer);
}

class ImageFileController extends ImageController {
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

@JsonSerializable()
class AegisIconRoot {
  final List<AegisIcon> icons;

  AegisIconRoot({required this.icons});

  factory AegisIconRoot.fromJson(Map<String, dynamic> json) =>
      _$AegisIconRootFromJson(json);

  Map<String, dynamic> toJson() => _$AegisIconRootToJson(this);

  AegisIcon? findIssuer(String issuer) {
    for (AegisIcon icon in icons) {
      if (icon.issuer.contains(issuer)) {
        return icon;
      }
    }
    return null;
  }
}

@JsonSerializable()
class AegisIcon {
  final String filename;
  final List<String> issuer;

  AegisIcon({required this.filename, required this.issuer});

  factory AegisIcon.fromJson(Map<String, dynamic> json) =>
      _$AegisIconFromJson(json);

  Map<String, dynamic> toJson() => _$AegisIconToJson(this);

  String path() {
    return "assets/aegis-icons/$filename";
  }
}
