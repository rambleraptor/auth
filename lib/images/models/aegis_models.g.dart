// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aegis_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AegisIconRoot _$AegisIconRootFromJson(Map<String, dynamic> json) =>
    AegisIconRoot(
      icons: (json['icons'] as List<dynamic>)
          .map((e) => AegisIcon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AegisIconRootToJson(AegisIconRoot instance) =>
    <String, dynamic>{
      'icons': instance.icons,
    };

AegisIcon _$AegisIconFromJson(Map<String, dynamic> json) => AegisIcon(
      filename: json['filename'] as String,
      issuer:
          (json['issuer'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AegisIconToJson(AegisIcon instance) => <String, dynamic>{
      'filename': instance.filename,
      'issuer': instance.issuer,
    };
