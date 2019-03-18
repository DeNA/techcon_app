// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(json['name'] as String, json['url'] as String);
}

Map<String, dynamic> _$ServiceToJson(Service instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
