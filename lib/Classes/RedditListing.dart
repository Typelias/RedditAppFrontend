import 'package:reddit_frontend/Classes/RedditPost.dart';

class RedditListing {
  final String after;
  List<RedditPost> postList = [];

  RedditListing({required this.after, required this.postList});

  factory RedditListing.fromJson(dynamic json) {
    var listObj = json['postList'] as List;
    List<RedditPost> list = listObj.map((e) => RedditPost.fromJson(e)).toList();

    return RedditListing(after: json['after'] as String, postList: list);
  }
}
