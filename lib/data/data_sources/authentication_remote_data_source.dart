import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/data/models/authentication/account_infomation_response.dart';
import 'package:custom_listview_with_json_data/data/models/authentication/request_token_response.dart';

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();

  Future<RequestTokenModel> createSessionWithLogin(
      Map<String, dynamic> requestBody);

  Future<String?> createSession(Map<String, dynamic> requestBody);

  Future<bool> deleteSession(String sessionID);

  Future<AccountInfoModel> getAccountID(String sessionID);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<String?> createSession(Map<String, dynamic> requestBody) async {
    final response = await _client.post(ApiConstants.POST_CREATE_SESSION_PATH,
        requestBody: requestBody);
    return response['success'] ? response['session_id'] : null;
  }

  @override
  Future<RequestTokenModel> createSessionWithLogin(
      Map<String, dynamic> requestBody) async {
    final response = await _client.post(
        ApiConstants.POST_CREATE_LOGIN_SESSION_PATH,
        requestBody: requestBody);
    return RequestTokenModel.fromJson(response);
  }

  @override
  Future<RequestTokenModel> getRequestToken() async {
    final response = await _client.get(ApiConstants.GET_REQUEST_TOKEN_PATH);
    return RequestTokenModel.fromJson(response);
  }

  @override
  Future<bool> deleteSession(String sessionID) async {
    final response = await _client.delete(ApiConstants.DELETE_SESSION_PATH,
        requestBody: {'session_id': sessionID});
    return response['success'] ?? false;
  }

  @override
  Future<AccountInfoModel> getAccountID(String sessionID) async {
    final response = await _client
        .get(ApiConstants.GET_ACCOUNT_PATH, params: {'session_id': sessionID});
    return AccountInfoModel.fromJson(response);
  }
}
