import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String password;
  String token = "";

  User(@required this.username, @required this.password);

  Future<String> doLogin() async {
    final response = await http.post(
        Uri.parse("http://localhost:8080/login"), body: jsonEncode(<String, String>{
      "username": this.username,
      "password": this.password
    }));

    this.token = json.decode(response.body)["Token"];
    print(this.token);

    return this.token;
  }
}