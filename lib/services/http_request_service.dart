import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class HttpRequestService {
  String url;

  HttpRequestService({required this.url});

  String getUrl(String? extension) {
    return "http://$url${getPath(extension)}";
  }

  String removeUrl(String? path) {
    if (path == null) return "";
    return path.replaceAll(getUrl(null), "");
  }

  String getPath(String? pathExtension) {
    const String path = "/";
    if (pathExtension == null) {
      return path;
    }

    return path + pathExtension;
  }

  Uri getURI({String? pathExtension, Map<String, dynamic>? queryParameters}) {
    return Uri.http(url, getPath(pathExtension), queryParameters);
  }

  Map<String, String> getHeaders() {
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    return headers;
  }

  Future<dynamic> handleResponse(http.Response response) async {
    final int code = response.statusCode;
    final dynamic body = jsonDecode(response.body);

    if (code == HttpStatus.ok) {
      return Future.value(body);
    }

    return Future.error(body as Map<String, dynamic>);
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      getURI(pathExtension: path),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );

    return handleResponse(response);
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await http.get(
      getURI(
        pathExtension: path,
        queryParameters: queryParameters,
      ),
      headers: getHeaders(),
    );

    return handleResponse(response);
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    final response = await http.put(
      getURI(
        pathExtension: path,
      ),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );

    return handleResponse(response);
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) async {
    final response = await http.patch(
      getURI(
        pathExtension: path,
      ),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );

    return handleResponse(response);
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) async {
    final response = await http.delete(
      getURI(
        pathExtension: path,
      ),
      headers: getHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );

    return handleResponse(response);
  }
}
