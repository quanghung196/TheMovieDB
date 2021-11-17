import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/authentication_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class UserLoginUseCase extends UseCase<bool, UserLoginParam> {
  final AuthenticationRepository _authenticationRepository;

  UserLoginUseCase(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(UserLoginParam params) async {
    return await _authenticationRepository.userLogin(params.toJson());
  }
}

class UserLoginParam {
  final String userName;
  final String userPassword;

  UserLoginParam({required this.userName, required this.userPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = userName;
    data['password'] = userPassword;
    return data;
  }
}
