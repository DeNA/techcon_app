/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'dart:async';

import 'package:repository/entity/person.dart';
import 'package:repository/entity/session.dart';
import 'package:repository/repository.dart';
import 'package:repository_local/assets.dart';

class RepositoryLocal implements Repository {
  @override
  Future<Session> getSessionById(String id) {
    // TODO: implement getSessionById
    return null;
  }

  @override
  Future<List<Session>> getSessionList() async {
    return sessionsData.map((data) => Session.fromJson(data)).toList();
  }

  @override
  Future<List<Person>> getPersonList() async {
    // TODO: implement getSessionById
    return null;
  }
}
