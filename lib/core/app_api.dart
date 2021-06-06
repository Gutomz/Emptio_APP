import 'dart:convert';
import 'dart:io';

import 'package:emptio/stores/auth.store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class AppApi {
  final String _url = '192.168.100.106:3000';

  String _getPath(String? pathExtension) {
    String path = "/api";
    if (pathExtension == null) {
      return path;
    }

    return path + pathExtension;
  }

  Uri _getURI({String? pathExtension, Map<String, dynamic>? queryParameters}) {
    return Uri.http(_url, _getPath(pathExtension), queryParameters);
  }

  Map<String, String> _getHeaders() {
    String token = GetIt.I<AuthStore>().auth?.token ?? "";

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    return headers;
  }

  _handleResponse(http.Response response) {
    int code = response.statusCode;
    var body = jsonDecode(response.body);

    if (code == HttpStatus.ok) {
      return Future.value(body);
    }
    if (code == HttpStatus.unauthorized || code == HttpStatus.forbidden) {
      // TODO - Deslogar usuário
    }

    return Future.error(body);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      _getURI(pathExtension: path),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> get(String path, Map<String, dynamic> queryParameters) async {
    final response = await http.get(
      _getURI(
        pathExtension: path,
        queryParameters: queryParameters,
      ),
      headers: _getHeaders(),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final response = await http.put(
      _getURI(
        pathExtension: path,
      ),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> patch(String path, Map<String, dynamic> body) async {
    final response = await http.patch(
      _getURI(
        pathExtension: path,
      ),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<http.Response> delete(String path, Map<String, dynamic> body) async {
    final response = await http.delete(
      _getURI(
        pathExtension: path,
      ),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }
}
