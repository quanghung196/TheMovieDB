part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginToAppEvent extends LoginEvent {
  final String? userName, password;
  final bool isGuest;

  const LoginToAppEvent({this.userName, this.password, this.isGuest = false});

  @override
  List<Object?> get props => [userName, password];
}

class LogoutFromAppEvent extends LoginEvent {}
