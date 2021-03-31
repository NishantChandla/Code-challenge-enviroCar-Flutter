part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  final User user;
  const SignUpLoading(this.user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpLoading &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;
}

class SignUpAuthenticated extends SignUpState {
  const SignUpAuthenticated();
}

class SignUpError extends SignUpState {
  final String message;
  const SignUpError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
