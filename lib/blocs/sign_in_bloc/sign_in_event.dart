part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInAuthenticateEvent extends SignInEvent {
  final String username, token;

  SignInAuthenticateEvent(this.username, this.token);
}

class CheckIfSignedInEvent extends SignInEvent {
  CheckIfSignedInEvent();
}

class SignOutEvent extends SignInEvent {
  SignOutEvent();
}
