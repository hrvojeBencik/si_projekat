part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UninitializedAuthenticationState extends AuthenticationState {}

class UnauthenticatedState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final String email;

  const AuthenticatedState(this.email);

  @override
  List<Object> get props => [email];
}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class NotVerifiedEmailState extends AuthenticationState {}

class PasswordResetMailSentState extends AuthenticationState {}
