part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInAuthenticated extends SignInState {
  final User headers;
  SignInAuthenticated(this.headers);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInAuthenticated &&
          runtimeType == other.runtimeType &&
          headers == other.headers;

  @override
  int get hashCode => headers.hashCode;
}

class SignInError extends SignInState {
  final String message;
  const SignInError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignedOut extends SignInState {
  const SignedOut();
}

class SignOutError extends SignInState {
  final String message;
  SignOutError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignOutError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
