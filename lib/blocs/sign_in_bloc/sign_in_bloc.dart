import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envirocar/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:envirocar/models/user.dart';
import 'package:envirocar/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  AuthenticationRepository _authenticationRepository;
  SignInBloc(this._authenticationRepository) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SignInAuthenticateEvent) {
      try {
        yield SignInLoading();
        bool result = await _authenticationRepository.signInWithCredentials(
            name: event.username, token: event.token);
        if (result) {
          yield SignInAuthenticated(
              User.headers(name: event.username, token: event.token));
        } else {
          yield SignInInitial();
        }
      } on NetworkException catch (e) {
        yield SignInError(e.message.toString());
      }
    }

    if (event is CheckIfSignedInEvent) {
      try {
        User user = await _authenticationRepository.checkIfSignedIn();
        yield SignInAuthenticated(user);
      } catch (e) {
        yield SignInError(e.toString());
      }
    }

    if (event is SignOutEvent) {
      try {
        await _authenticationRepository.signOut();
        yield SignedOut();
      } catch (e) {
        print(e.toString());
        yield SignOutError(e.toString());
      }
    }
  }
}
