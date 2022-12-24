import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_controller.g.dart';

abstract class ImageController {
  Future<Widget?> widgetForIssuer(String url);
}

class ImageFileController extends ImageController {
  @override
  Future<Widget?> widgetForIssuer(String issuer) {
    return jsonFile().then((root) => root.findIssuer(issuer)?.svgIcon());
  }

  String fileName(String url) {
    return "assets/twofactorauth/img/${url[0]}/$url.svg";
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
      if (icon.issuers.contains(issuer)) {
        return icon;
      }
    }
    return null;
  }
}

@JsonSerializable()
class AegisIcon {
  final String path;
  final List<String> issuers;

  AegisIcon({required this.path, required this.issuers});

  factory AegisIcon.fromJson(Map<String, dynamic> json) =>
      _$AegisIconFromJson(json);

  Map<String, dynamic> toJson() => _$AegisIconToJson(this);

  Widget svgIcon() {
    return SvgPicture.asset(
      path,
      semanticsLabel: "${issuers[0]} Logo",
    );
  }
}
