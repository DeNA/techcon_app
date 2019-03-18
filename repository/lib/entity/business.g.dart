// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business(
      json['id'] as int,
      json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      (json['services'] as List)
          ?.map((e) =>
              e == null ? null : Service.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['stage'] as String,
      json['start_at'] as String,
      json['end_at'] as String,
      (json['tags'] as List)?.map((e) => e as String)?.toList(),
      json['title'] as String,
      json['text'] as String);
}

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'services': instance.services,
      'stage': instance.stage,
      'start_at': instance.startAt,
      'end_at': instance.endAt,
      'tags': instance.tags,
      'title': instance.title,
      'text': instance.text
    };
