import 'dart:convert';
import 'dart:io';

import 'package:emptio/services/http_request_service.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/environment.store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class AppApi extends HttpRequestService {
  AppApi() : super(url: GetIt.I<EnvironmentStore>().apiUrl);

  @override
  String getPath(String? pathExtension) {
    const String path = "/api";
    if (pathExtension == null) {
      return path;
    }

    return path + pathExtension;
  }

  @override
  Map<String, String> getHeaders() {
    final String token = GetIt.I<AuthStore>().auth?.token ?? "";

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    return headers;
  }

  @override
  Future<dynamic> handleResponse(http.Response response) async {
    final int code = response.statusCode;
    final dynamic body = jsonDecode(response.body);

    if (code == HttpStatus.ok) {
      return Future.value(body);
    } else if (code == HttpStatus.unauthorized) {
      final AuthStore store = GetIt.I<AuthStore>();
      store.clear();
    }

    return Future.error(body as Map<String, dynamic>);
  }
}
