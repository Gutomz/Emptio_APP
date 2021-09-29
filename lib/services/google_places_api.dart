import 'dart:convert';

import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/services/http_request_service.dart';
import 'package:emptio/stores/environment.store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends HttpRequestService {
  final String _key = GetIt.I<EnvironmentStore>().googlePlacesKey;

  GooglePlacesApi() : super(url: 'maps.googleapis.com');

  @override
  String getUrl(String? extension) {
    return "https://$url${getPath(extension)}";
  }

  @override
  String getPath(String? pathExtension) {
    const String path = "/maps/api/place";
    if (pathExtension == null) {
      return path;
    }

    return path + pathExtension;
  }

  @override
  Uri getURI({String? pathExtension, Map<String, dynamic>? queryParameters}) {
    final path = StringBuffer(pathExtension ?? "");

    if (queryParameters != null) {
      path.write("?");
      var separator = "";
      for (int i = 0; i < queryParameters.keys.length; i++) {
        path.write(separator);
        path.write("${queryParameters.keys.elementAt(i)}=");
        path.write("${queryParameters.values.elementAt(i)}");
        separator = "&";
      }
    }

    return Uri.parse(getUrl(path.toString()));
  }

  // @override
  // Uri getURI({String? pathExtension, Map<String, dynamic>? queryParameters}) {
  //   return Uri.https(url, getPath(pathExtension), queryParameters);
  // }

  @override
  Map<String, String> getHeaders() {
    final Map<String, String> headers = {};

    return headers;
  }

  @override
  Future<dynamic> handleResponse(http.Response response) async {
    final dynamic body = jsonDecode(response.body) as Map<String, dynamic>;
    final String code = JsonParser.parseToString(body['status']);

    if (code.contains('OK') || code.contains('ZERO_RESULTS')) {
      return Future.value(body);
    }

    return Future.error(body as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> autocomplete(String sessionId,
      {Map<String, dynamic>? queryParameters}) async {
    queryParameters ??= {};

    queryParameters['key'] = _key;
    queryParameters['sessionId'] = sessionId;

    final response =
        await get('/autocomplete/json', queryParameters: queryParameters);

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> details(String sessionId,
      {Map<String, dynamic>? queryParameters}) async {
    queryParameters ??= {};

    queryParameters['key'] = _key;
    queryParameters['sessionId'] = sessionId;

    final response =
        await get('/details/json', queryParameters: queryParameters);

    return response as Map<String, dynamic>;
  }
}
