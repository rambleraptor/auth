// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_controller.dart';

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
      path: json['path'] as String,
      issuers:
          (json['issuers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AegisIconToJson(AegisIcon instance) => <String, dynamic>{
      'path': instance.path,
      'issuers': instance.issuers,
    };
