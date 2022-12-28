import 'package:json_annotation/json_annotation.dart';

part 'aegis_models.g.dart';

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
