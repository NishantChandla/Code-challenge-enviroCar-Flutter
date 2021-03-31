import 'dart:core';

class User {
  String name;
  String email;
  String token;
  bool acceptedPrivacy;
  bool acceptedTerms;
  bool isLogged;

  User(
      {this.name,
      this.email,
      this.token,
      this.acceptedPrivacy,
      this.acceptedTerms});

  User.headers({this.name, this.token});
}
