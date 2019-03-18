/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:json_annotation/json_annotation.dart";

part "category.g.dart";

@JsonSerializable()
class Category {
  String text;
  String icon;

  Category(this.text, this.icon);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category &&
              runtimeType == other.runtimeType &&
              text == other.text &&
              icon == other.icon;

  @override
  int get hashCode =>
      text.hashCode ^
      icon.hashCode;

  @override
  String toString() {
    return 'Category{text: $text, icon: $icon}';
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

}

