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
  final String firstName;
  final String lastName;
  final String image;

  const RegisterEvent({required this.email, required this.password, required this.firstName, required this.lastName, this.image = ''});

  @override
  List<Object> get props => [email, password];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthenticationEvent {}

class SwitchAuthFormEvent extends AuthenticationEvent {}

class SendVerificationMailEvent extends AuthenticationEvent {}

class GoToHomePageEvent extends AuthenticationEvent {}
