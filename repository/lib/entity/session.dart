/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import "package:json_annotation/json_annotation.dart";
import 'package:repository/entity/business.dart';
import 'package:repository/entity/person.dart';

part "session.g.dart";

@JsonSerializable()
class Session {
  int id;
  List<Person> persons;
  Business business;

  Session(this.id, this.persons, this.business);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Session &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          persons == other.persons &&
          business == other.business;

  @override
  int get hashCode => id.hashCode ^ persons.hashCode ^ business.hashCode;

  @override
  String toString() {
    return 'Session{id: $id, persons: $persons, business: $business}';
  }

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
