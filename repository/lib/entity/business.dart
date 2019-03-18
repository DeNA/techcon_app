/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:json_annotation/json_annotation.dart";
import 'package:repository/entity/category.dart';
import 'package:repository/entity/service.dart';

part "business.g.dart";

@JsonSerializable()
class Business {
  int id;
  Category category;
  List<Service> services;
  String stage;
  @JsonKey(name: 'start_at') String startAt;
  @JsonKey(name: 'end_at') String endAt;
  List<String> tags;
  String title;
  String text;

  Business(this.id, this.category, this.services, this.stage, this.startAt,
      this.endAt, this.tags, this.title, this.text);

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Business &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              category == other.category &&
              services == other.services &&
              stage == other.stage &&
              startAt == other.startAt &&
              endAt == other.endAt &&
              tags == other.tags &&
              title == other.title &&
              text == other.text;

  @override
  int get hashCode =>
      id.hashCode ^
      category.hashCode ^
      services.hashCode ^
      stage.hashCode ^
      startAt.hashCode ^
      endAt.hashCode ^
      tags.hashCode ^
      title.hashCode ^
      text.hashCode;

  @override
  String toString() {
    return 'Business{id: $id, category: $category, services: $services, stage: $stage, startAt: $startAt, endAt: $endAt, tags: $tags, title: $title, text: $text}';
  }

}
