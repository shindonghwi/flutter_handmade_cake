// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseOrdersCake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOrdersCake _$ResponseOrdersCakeFromJson(Map<String, dynamic> json) =>
    ResponseOrdersCake(
      size: json['size'] as String,
      sheet: json['sheet'] as String,
      taste: json['taste'] as String,
      jam: json['jam'] as String,
      imageUrl: json['imageUrl'] as String,
          decorations: (json['decorations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ResponseOrdersCakeToJson(ResponseOrdersCake instance) =>
    <String, dynamic>{
      'size': instance.size,
      'sheet': instance.sheet,
      'taste': instance.taste,
      'jam': instance.jam,
      'imageUrl': instance.imageUrl,
      'decorations': instance.decorations,
    };
