import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];
}

enum AppErrorType { API, NETWORK, DATABASE, UNAUTHORISE, SESSION_DENIED, NONE }
