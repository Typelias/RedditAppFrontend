import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:reddit_frontend/Classes/RedditListing.dart';
import 'package:http/http.dart' as http;

class FrontPageListing with ChangeNotifier {
  RedditListing? redditListing;

  Future<void> init(String token) async {
    var resp = await http.get(Uri.parse("http://localhost:8080/frontpage"),
        headers: <String, String>{"Authorization": token});

    redditListing = RedditListing.fromJson(jsonDecode(resp.body));
    notifyListeners();
  }
}
