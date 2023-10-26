import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'json_tools.dart';
import 'tools.dart';

extension ApiFuture<T> on Future<T> {
  Future<R> apiThen<R>(FutureOr<R> Function(T v) onValue,
      {FutureOr<R> Function(ApiNotFoundException)? onNotFound,
      FutureOr<R> Function(ApiForbiddenException)? onForbidden,
      FutureOr<R> Function(dynamic e)? onError}) async {
    try {
      return onValue(await this);
    } catch (e) {
      if (e is ApiNotFoundException && onNotFound != null) {
        return onNotFound(e);
      } else if (e is ApiForbiddenException && onForbidden != null) {
        return onForbidden(e);
      }
      if (onError != null) return onError(e);
      rethrow;
    }
  }
}

Future<String> _apiDo(Uri uri, Future<Response> Function() worker) async {
  try {
    logger.v("apiTools: sending request to $uri");
    return (await worker.call()).bodyOrThrow(uri);
  } on ApiException catch (_) {
    rethrow;
  } catch (e, s) {
    logger.t("apiTools: network error on $uri", error: e, stackTrace: s);
    throw ApiConnectionException(uri, e);
  }
}

/// a save interface for executing get queries. Will throw an ApiException
/// when something goes wrong
Future<String> apiGet({required Uri uri, JsonMap<String>? headers}) =>
    _apiDo(uri, () => http.get(uri, headers: headers));

/// a save interface for executing delete queries. Will throw an ApiException
/// when something goes wrong
Future<String> apiDelete({required Uri uri, JsonMap<String>? headers}) =>
    _apiDo(uri, () => http.delete(uri, headers: headers));

/// a save interface for executing post queries. Will throw an ApiException
/// when something goes wrong
Future<String> apiPost(
    {required Uri uri, JsonMap<String>? headers, Object? body}) {
  logger.v("POST BODY: $body");
  return _apiDo(uri, () => http.post(uri, headers: headers, body: body));
}

extension ApiResponse on Response {
  String bodyOrThrow<T>(Uri uri) {
    switch (statusCode) {
      case 200:
        return body;
      case 400:
        throw ApiBadRequestException(uri, body);
      case 401:
        throw ApiUnauthorizedException(uri, body);
      case 403:
        throw ApiForbiddenException(uri, body);
      case 404:
        throw ApiNotFoundException(uri, body);
      case 500:
        throw ApiServerException(uri, body);
      default:
        throw ApiException(
            statusCode, uri, body, "undefined exception: Body: $body");
    }
  }
}

class ApiException implements Exception {
  final Uri uri;
  final int code;
  final String message;
  final dynamic serverMessage;

  final String uiTitle;
  final String uiMessage;
  final IconData uiIcon;
  const ApiException(this.code, this.uri, this.serverMessage, this.message,
      {this.uiTitle = "Die Daten konnten nicht geladen werden",
      this.uiMessage = "Prüfen Sie Ihre Verbindung",
      this.uiIcon = LucideIcons.cloudOff});

  @override
  String toString() => "API-Exception: $message\n  Uri: '$uri':"
      "\nServer response: $serverMessage";
}

class ApiConnectionException extends ApiException {
  const ApiConnectionException(Uri uri, dynamic exception)
      : super(000, uri, null, "Connection Exception: $exception",
            uiTitle: "keine Verbindung",
            uiMessage: "Prüfe deine Verbindung",
            uiIcon: LucideIcons.cloudOff);
}

class ApiNotFoundException extends ApiException {
  const ApiNotFoundException(Uri uri, dynamic serverMessage)
      : super(404, uri, serverMessage, "Not Found",
            uiTitle: "Daten nicht gefunden",
            uiMessage: "Die Daten konnten nicht gefunden werden",
            uiIcon: LucideIcons.searchX);
}

class ApiForbiddenException extends ApiException {
  const ApiForbiddenException(Uri uri, dynamic serverMessage)
      : super(403, uri, serverMessage, "Forbidden",
            uiTitle: "fehlende Berechtigung",
            uiMessage: "Du bist nicht berechtigt, diese Daten zu laden",
            uiIcon: LucideIcons.ban);
}

class ApiUnauthorizedException extends ApiException {
  const ApiUnauthorizedException(Uri uri, dynamic serverMessage)
      : super(401, uri, serverMessage, "Unauthorized",
            uiTitle: "nicht angemeldet",
            uiMessage: "Melde dich an, um diese Daten zu laden",
            uiIcon: LucideIcons.keyRound);
}

class ApiBadRequestException extends ApiException {
  const ApiBadRequestException(Uri uri, dynamic serverMessage)
      : super(400, uri, serverMessage, "Bad Request",
            uiTitle: "unklare Anfrage",
            uiMessage: "Der Server hat die Anfrage nicht verstanden",
            uiIcon: LucideIcons.fileQuestion);
}

class ApiServerException extends ApiException {
  const ApiServerException(Uri uri, dynamic serverMessage)
      : super(500, uri, serverMessage, "Internal Server Error",
            uiTitle: "Server Fehler",
            uiMessage: "Auf dem Server ist ein Fehler aufgetreten",
            uiIcon: LucideIcons.serverCrash);
}
