import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String username = "";
  String password = "";
  String token = "";

  void setUser(String username, String password) {
    this.username = username;
    this.password = password;
  }

  Future<String> doLogin() async {
    final response = await http.post(Uri.parse("http://localhost:8080/login"),
        body: jsonEncode(<String, String>{
          "username": this.username,
          "password": this.password
        }));

    this.token = json.decode(response.body)["Token"];
    print(this.token);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(username, token);
    prefs.setString("last-user", username);

    return this.token;
  }

  Future<bool> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("last-user")) {
      var user = prefs.getString("last-user");
      this.token = prefs.getString(user!)!;
      return true;
    }

    return false;
  }

}
