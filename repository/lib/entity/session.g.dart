// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
      json['id'] as int,
      (json['persons'] as List)
          ?.map((e) =>
              e == null ? null : Person.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'persons': instance.persons,
      'business': instance.business
    };
