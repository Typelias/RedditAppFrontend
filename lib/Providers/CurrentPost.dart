import 'package:flutter/material.dart';
import 'package:reddit_frontend/Classes/RedditPost.dart';

class CurrentPost with ChangeNotifier {
  RedditPost? currentPost;

  void current(RedditPost newPost) {
    currentPost = newPost;
    notifyListeners();
  }

}