import 'dart:convert';

import 'package:flutter/material.dart';

import '../util/api_tools.dart';
import '../util/json_tools.dart';
import '../util/tools.dart';

class ExcubiaApiRepo {
  final String host;
  final String basePath;
  final String? token;
  final VoidCallback? onUnauthorized;

  const ExcubiaApiRepo(
      {required this.host,
      required this.basePath,
      this.token,
      this.onUnauthorized});

  ExcubiaApiRepo copyWith(
          {String? host,
          String? basePath,
          VoidCallback? Function()? onUnauthorized,
          String? Function()? token}) =>
      ExcubiaApiRepo(
          host: host ?? this.host,
          basePath: basePath ?? this.basePath,
          token: token?.call() ?? this.token,
          onUnauthorized: onUnauthorized?.call() ?? this.onUnauthorized);

  JsonMap<String> get headers => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token'
      };

  Future<T> post<T>(
      {required String path,
      JsonMap? parameters,
      JsonMap? body,
      required T Function(JsonMap) parser}) async {
    final uri = _makeUri(path, parameters);
    logger.t("posting parameters: $parameters");
    return _parse<T, JsonMap>(
        await apiPost(uri: uri, headers: headers, body: jsonEncode(body)),
        parser);
  }

  Future<void> delete<T>({required String path, JsonMap? parameters}) =>
      apiDelete(uri: _makeUri(path, parameters), headers: headers);

  Future<T> get<T>(
          {required String path,
          JsonMap? parameters,
          required T Function(JsonMap) parser}) async =>
      _parse<T, JsonMap>(
          await apiGet(uri: _makeUri(path, parameters), headers: headers),
          parser);

  Future<List<T>> getList<T>(
          {required String path,
          JsonMap? parameters,
          required T Function(JsonMap) parser}) async =>
      _parseList<T>(
          await apiGet(uri: _makeUri(path, parameters), headers: headers),
          parser);

  Future<T> getCustom<T, I>(
          {required String path,
          JsonMap? parameters,
          required T Function(I) parser}) async =>
      _parse<T, I>(
          await apiGet(uri: _makeUri(path, parameters), headers: headers),
          parser);

  // ==== INTERNAL ====

  Uri _makeUri(String apiPath, JsonMap? parameters) => Uri.https(
      host,
      basePath + apiPath,
      (parameters
          ?.where((_, v) => v != null)
          .map((k, v) => MapEntry(k, "$v"))));

  List<T> _parseList<T>(String body, T Function(JsonMap) parser) {
    try {
      return (jsonDecode(body) as List).map((e) => parser(e)).toList();
    } catch (e) {
      throw Exception("error parsing list body: \n$e\nbody was: $body");
    }
  }

  T _parse<T, I>(String body, T Function(I) parser) {
    try {
      return parser(jsonDecode(body) as I);
    } catch (e) {
      throw Exception("error parsing body: \n$e\nbody was: $body");
    }
  }
}
