import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envirocar/models/user.dart';
import 'package:envirocar/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthenticationRepository _authenticationRepository;
  SignUpBloc(this._authenticationRepository) : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpAuthenticateEvent) {
      try {
        yield SignUpLoading(event.user);
        await _authenticationRepository.signUpWithCredentials(event.user);
        yield SignUpAuthenticated();
      } on NetworkException catch (e) {
        yield SignUpError("Couldn't Sign up," + e.message.toString());
      }
    }
  }
}
