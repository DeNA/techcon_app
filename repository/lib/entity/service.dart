/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:json_annotation/json_annotation.dart';

part "service.g.dart";

@JsonSerializable()
class Service {
  String name;
  String url;

  Service(this.name, this.url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Service &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              url == other.url;

  @override
  int get hashCode =>
      name.hashCode ^
      url.hashCode;

  @override
  String toString() {
    return 'Service{name: $name, url: $url}';
  }

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

}
