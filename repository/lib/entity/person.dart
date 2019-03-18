/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:json_annotation/json_annotation.dart";
import 'package:repository/entity/sns.dart';

part "person.g.dart";

@JsonSerializable()
class Person extends Object {
  int id;
  String name;
  String company;
  String team;
  String profile;
  String imageUrl;
  List<Sns> sns;

  Person(this.id, this.name, this.company, this.team, this.profile,
      this.imageUrl, this.sns);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          company == other.company &&
          team == other.team &&
          profile == other.profile &&
          imageUrl == other.imageUrl &&
          sns == other.sns;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      company.hashCode ^
      team.hashCode ^
      profile.hashCode ^
      imageUrl.hashCode ^
      sns.hashCode;

  @override
  String toString() {
    return 'Person{id: $id, name: $name, company: $company, team: $team, profile: $profile, imageUrl: $imageUrl, sns: $sns}';
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
