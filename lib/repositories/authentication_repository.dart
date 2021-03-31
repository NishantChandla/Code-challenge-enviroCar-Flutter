import 'dart:convert';

import 'package:envirocar/config/app_constants.dart';
import 'package:envirocar/models/user.dart';
import 'package:envirocar/repositories/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository implements BaseRepository {
  @override
  void dispose() {
    // TODO: implement dispose
  }
  Future<User> signUpWithCredentials(User user) async {
    http.Response response = await http.post(Uri.parse(API_URL + "/users/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': user.name,
          'mail': user.email,
          'token': user.token,
          'acceptedPrivacy': user.acceptedPrivacy,
          'acceptedTerms': user.acceptedTerms
        }));
    print(user.acceptedTerms.toString());
    print(response.body.toString());
    if (response.body.isEmpty) {
      return user;
    } else {
      String message =
          json.decode(response.body.toString())['message'].toString();
      if (message.isEmpty) {
        message = response.reasonPhrase.toString();
      }
      throw NetworkException(message);
    }
  }

  Future<bool> signInWithCredentials({String name, String token}) async {
    http.Response response = await http
        .get(Uri.parse(API_URL + "/users/" + name), headers: <String, String>{
      'Content-Type': 'application/json',
      'X-User': name,
      'X-Token': token,
    });
    if (response.statusCode == 403) {
      String message =
          jsonDecode(response.body.toString())['message'].toString();
      throw NetworkException(message);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('X-User', name);
      await prefs.setString('X-Token', token);
      return true;
    }
  }

  Future<User> checkIfSignedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('X-User');
    String token = sharedPreferences.getString('X-Token');
    if (name == null || token == null) {
      throw Exception("Not Logged in!");
    }
    return User.headers(name: name, token: token);
  }

  Future<bool> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('X-User');
    sharedPreferences.remove('X-Token');
    return true;
  }
}

class NetworkException implements Exception {
  String message;
  NetworkException(this.message);
}
