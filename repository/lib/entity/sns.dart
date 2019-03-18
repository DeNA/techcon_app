/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:json_annotation/json_annotation.dart";

part "sns.g.dart";

@JsonSerializable()
class Sns {
  String icon;
  String url;

  Sns(this.icon, this.url);

  factory Sns.fromJson(Map<String, dynamic> json) => _$SnsFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Sns &&
              runtimeType == other.runtimeType &&
              icon == other.icon &&
              url == other.url;

  @override
  int get hashCode =>
      icon.hashCode ^
      url.hashCode;

  @override
  String toString() {
    return 'Sns{icon: $icon, url: $url}';
  }

}
