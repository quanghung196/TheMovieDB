import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>> userLogin(Map<String, dynamic> requestBody);
  Future<Either<AppError, void>> userLogout();
}