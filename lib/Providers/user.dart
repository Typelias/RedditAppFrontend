import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String token = "";
  String refreshToken = "";
  String username = "";
  DateTime expires = DateTime.now();
  Map<String, String> users = {};

  Future<void> doLogin(String code) async {
    final response = await http.post(Uri.parse("http://localhost:8080/login"),
    body: jsonEncode(<String, String>{
      "code": code
    }));
    var body = json.decode(response.body);
    //print(body["Token"] + "\n" +body["Refresh"]);

    final userResp = await http.get(Uri.parse("https://oauth.reddit.com/api/v1/me"), headers: <String,String>{
      "Authorization": "bearer " + body["Token"],
    });

    var userBody = json.decode(userResp.body);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Name:"+userBody["name"], body["Refresh"]);
    await prefs.setString("last-user", userBody["name"]);
    token = body["Token"];
    refreshToken = body["Refresh"];
    expires = DateTime.now().add(new Duration(hours: 1));
    notifyListeners();
  }


  doLogOut() async{
    final prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    if(!keys.isNotEmpty) {
      return;
    }
    for(var i = 0; i < keys.length; i++) {
      await prefs.remove(keys.elementAt(i));
    }
    notifyListeners();
  }

  Future<String> refreshKey(String token) async {
    final resp = await http.post(Uri.parse("http://localhost:8080/refresh"), headers: <String, String> {
      "Authorization": token,
    });

    var body = json.decode(resp.body);

    return body["token"];

}

  Future<String> get getToken async {
    if(this.expires.isBefore(DateTime.now())) {
      this.token = await this.refreshKey(this.refreshToken);
    }

    return token;
  }

  Future<bool> checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    if(!keys.isNotEmpty) {
      return false;
    }
    Map<String,String> users = {};
    for(var i = 0; i < keys.length; i++) {
      var key = keys.elementAt(i);
      if(key.contains("Name:")) {
        var name = key.split(":")[1];
        users[name] = await prefs.getString(key) as String;
      }
    }
    if(users.isEmpty) {
      return false;
    }

    this.users = users;

    String? lastUser = await prefs.getString("last-user");

    if(lastUser == null) {
      return false;
    }

    if(this.users.containsKey(lastUser)) {
      this.refreshToken = users[lastUser]!;
      this.username = lastUser;

    } else {
      this.refreshToken = users[users.keys.first]!;
      this.username = users.keys.first;
    }
    this.token = await this.refreshKey(this.refreshToken);
    this.expires = DateTime.now().add(new Duration(hours: 1));

    print(this.refreshToken);

    return true;
  }

}
