/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

library repository;

import 'package:repository/entity/person.dart';
import 'package:repository/entity/session.dart';


abstract class Repository {
  Future<List<Session>> getSessionList();
  Future<Session> getSessionById(String id);
  Future<List<Person>> getPersonList();
}
