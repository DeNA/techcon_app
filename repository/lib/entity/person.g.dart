// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      json['id'] as int,
      json['name'] as String,
      json['company'] as String,
      json['team'] as String,
      json['profile'] as String,
      json['imageUrl'] as String,
      (json['sns'] as List)
          ?.map(
              (e) => e == null ? null : Sns.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'team': instance.team,
      'profile': instance.profile,
      'imageUrl': instance.imageUrl,
      'sns': instance.sns
    };
