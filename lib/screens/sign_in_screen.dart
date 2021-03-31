import 'package:envirocar/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:envirocar/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget _signInForm([User data]) {
    TextEditingController nameCon = TextEditingController();
    TextEditingController tokenCon = TextEditingController();

    if (data != null) {
      nameCon.text = (data.name);
      tokenCon.text = data.token;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameCon,
              decoration: InputDecoration(hintText: "User Name"),
            ),
            TextFormField(
              controller: tokenCon,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.blue,
              child: MaterialButton(
                onPressed: () {
                  submitSignIn(context, nameCon.text, tokenCon.text);
                  // _widgetLoading();
                },
                child: Text("Submit"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("If you don't have a account"),
            Container(
              color: Colors.blue,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sign_up');
                },
                child: Text("Sign up"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitSignIn(BuildContext context, String name, String token) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);
    signInBloc.add(SignInAuthenticateEvent(name, token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInAuthenticated) {
              Navigator.pop(context);
            } else if (state is SignInError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is SignInInitial) {
              return _signInForm();
            } else if (state is SignInLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _signInForm();
            }
          },
        ));
  }
}
