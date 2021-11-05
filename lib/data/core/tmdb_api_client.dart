import 'dart:convert';

import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_exception.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  Future<dynamic> get(String path, {Map<dynamic, dynamic>? params}) async {
    var responseJson;
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    responseJson = _tmdbResponse(response);
    return responseJson;
  }

  dynamic _tmdbResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with status code : ${response.statusCode}');
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return Uri.parse('${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString');
  }
}
