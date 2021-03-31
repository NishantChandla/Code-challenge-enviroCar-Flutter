part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpAuthenticateEvent extends SignUpEvent {
  final User user;

  SignUpAuthenticateEvent(this.user);
}
