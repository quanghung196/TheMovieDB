import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/repositories/authentication_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class UserLogoutUseCase extends UseCase<void, NoParams>{

  final AuthenticationRepository _authenticationRepository;

  UserLogoutUseCase(this._authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async =>
    await _authenticationRepository.userLogout();
}