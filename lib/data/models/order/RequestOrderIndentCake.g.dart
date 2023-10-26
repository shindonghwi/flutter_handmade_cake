// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestOrderIndentCake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOrderIndentCake _$RequestOrderIndentCakeFromJson(
        Map<String, dynamic> json) =>
    RequestOrderIndentCake(
      size: json['size'] as String,
      sheet: json['sheet'] as String,
      taste: json['taste'] as String,
      jam: json['jam'] as String,
      imagePath: json['imagePath'] as String,
      decorations: (json['decorations'] as List<dynamic>)
          .map((e) =>
              RequestOrderIndentDecoration.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestOrderIndentCakeToJson(
        RequestOrderIndentCake instance) =>
    <String, dynamic>{
      'size': instance.size,
      'sheet': instance.sheet,
      'taste': instance.taste,
      'jam': instance.jam,
      'imagePath': instance.imagePath,
      'decorations': instance.decorations,
    };
