import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/data/repositories/app_setting_repository_impl.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/user_login_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/user_logout_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase userLoginUseCase;
  final UserLogoutUseCase userLogoutUseCase;
  final AppSettingRepository appSettingRepository;
  final LoadingBloc loadingBloc;

  LoginBloc(
      {required this.loadingBloc,
      required this.userLogoutUseCase,
      required this.userLoginUseCase,
      required this.appSettingRepository})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginToAppEvent) {
      if (event.isGuest) {
        appSettingRepository
            .saveSessionID(AppSettingRepositoryImpl.SESSION_ID_GUEST);
        yield LoginSuccess();
      } else {
        loadingBloc.add(StartLoadingEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
        final response = await userLoginUseCase(UserLoginParam(
            userPassword: event.password!, userName: event.userName!));
        yield response.fold((error) {
          var message = _getErrorMessage(error.appErrorType);
          return LoginError(message);
        }, (response) {
          return LoginSuccess();
        });
        loadingBloc.add(FinishLoadingEvent());
      }
    } else if (event is LogoutFromAppEvent) {
      await userLogoutUseCase(NoParams());
      yield LogoutSuccess();
    }
  }

  String getSessionID() {
    return appSettingRepository.getSessionID();
  }

  String _getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.NETWORK:
        return TranslationConstants.noNetwork;
      case AppErrorType.API:
      case AppErrorType.DATABASE:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.SESSION_DENIED:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
