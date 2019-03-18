/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:repository/entity/person.dart';
import 'package:repository/entity/session.dart';
import 'package:repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryCache extends Repository {
  static const MethodChannel _channel = const MethodChannel('repository_cache');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // TODO: Change to your hosting url.
  final _baseUrl = 'https://localhost/json';

  @override
  Future<List<Person>> getPersonList() {
    // TODO: implement getPersonList
    return null;
  }

  @override
  Future<Session> getSessionById(String id) {
    // TODO: implement getSessionById
    return null;
  }

  @override
  Future<List<Session>> getSessionList() async {
    final _json = "sessions.json";
    final _url = "$_baseUrl/$_json";
    final client = http.Client();
    final SharedPreferences prefs = await _prefs;

    return client.get(_url).timeout(Duration(seconds: 5)).then((response) {
      if (response.statusCode == 200) {
        var data = utf8.decode(response.bodyBytes);
        prefs.setString(_json, data);
        return data;
      }
      throw ("[${response.statusCode}] Could not get $_json");
    }).catchError((error) {
      print("$error");
      return prefs.getString(_json);
    }).then((data) {
      List<Session> sessions = List<Session>();
      var decoded = jsonDecode(data);
      decoded.forEach((data) => sessions.add(Session.fromJson(data)));
      return sessions;
    }).catchError((error) {
      print("$error");
      return List<Session>();
    });
  }
}
