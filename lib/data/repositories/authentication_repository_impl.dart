import 'dart:io';

import 'package:custom_listview_with_json_data/data/core/tmdb_exception.dart';
import 'package:custom_listview_with_json_data/data/data_sources/authentication_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/models/authentication/request_token_response.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import 'app_setting_repository_impl.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AppSettingRepository _appSettingRepository;

  AuthenticationRepositoryImpl(
      this._authenticationRemoteDataSource, this._appSettingRepository);

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, bool>> userLogin(
      Map<String, dynamic> requestBody) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final requestToken = requestTokenEitherResponse
        .getOrElse(() => RequestTokenModel())
        .requestToken;

    try {
      requestBody.putIfAbsent('request_token', () => requestToken);
      final createSessionWithLogin = await _authenticationRemoteDataSource
          .createSessionWithLogin(requestBody);
      final sessionID = await _authenticationRemoteDataSource
          .createSession(createSessionWithLogin.toJson());
      if (sessionID != null) {
        _appSettingRepository.saveSessionID(sessionID);
        return const Right(true);
      }
      return const Left(AppError(AppErrorType.SESSION_DENIED));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.UNAUTHORISE));
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, void>> userLogout() async {
    if(_appSettingRepository.getSessionID() != AppSettingRepositoryImpl.SESSION_ID_GUEST){
      await _authenticationRemoteDataSource
          .deleteSession(_appSettingRepository.getSessionID());
    }
    _appSettingRepository.deleteSessionID();
    return const Right(Unit);
  }
}
