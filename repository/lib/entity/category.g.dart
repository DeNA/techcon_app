// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['text'] as String, json['icon'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) =>
    <String, dynamic>{'text': instance.text, 'icon': instance.icon};
