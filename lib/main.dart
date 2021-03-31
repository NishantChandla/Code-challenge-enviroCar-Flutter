import 'package:envirocar/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:envirocar/repositories/authentication_repository.dart';
import 'package:envirocar/screens/home_screen.dart';
import 'package:envirocar/screens/sign_in_screen.dart';
import 'package:envirocar/screens/sign_up_screen.dart';
import 'package:envirocar/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/sign_in_bloc/sign_in_bloc.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(authenticationRepository),
    ),
    BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(authenticationRepository),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/sign_in': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
