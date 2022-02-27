part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckUserStatusEvent extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const RegisterEvent(this.email, this.password);
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthenticationEvent {}
