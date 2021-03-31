import 'package:envirocar/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:envirocar/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _widgetSuccessfulAuthenticated() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('One step away'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text('Check your inbox to confirm account')),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sign_in');
                  },
                  child: Text('Close'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _signUpForm([User data]) {
    TextEditingController nameCon = TextEditingController();
    TextEditingController emailCon = TextEditingController();
    TextEditingController tokenCon = TextEditingController();

    if (data != null) {
      nameCon.text = (data.name);
      emailCon.text = data.email;
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
              controller: emailCon,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: tokenCon,
              decoration: InputDecoration(hintText: "Password"),
            ),
            TextFormField(
              controller: tokenCon,
              decoration: InputDecoration(hintText: "Confirm Password"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.blue,
              child: MaterialButton(
                onPressed: () {
                  submitSignUp(
                      context,
                      User(
                          name: nameCon.text,
                          email: emailCon.text,
                          token: tokenCon.text,
                          acceptedTerms: true,
                          acceptedPrivacy: true));
                  // _widgetLoading();
                },
                child: Text("Submit"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("If you already have an account"),
            Container(
              color: Colors.blue,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sign_in');
                },
                child: Text("Sign in"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitSignUp(BuildContext context, User user) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc.add(SignUpAuthenticateEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is SignUpAuthenticated) {
              _widgetSuccessfulAuthenticated();
            }
          },
          builder: (context, state) {
            if (state is SignUpInitial) {
              return _signUpForm();
            } else if (state is SignUpLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _signUpForm();
            }
          },
        ));
  }
}
