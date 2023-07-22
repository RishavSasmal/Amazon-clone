import 'dart:convert';

import 'package:backend_prac/constants/error_handling.dart';
import 'package:backend_prac/constants/global_variable.dart';
import 'package:backend_prac/constants/utils.dart';
import 'package:backend_prac/feature/home/screens/home_screen.dart';
import 'package:backend_prac/models/user.dart';
import 'package:backend_prac/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          password: password,
          name: name,
          address: '',
          type: '',
          token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=utf-8'
          });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8'
        },
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            final prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(response.body)["token"]);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
            // showSnackBar(context, 'login successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', "");
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
