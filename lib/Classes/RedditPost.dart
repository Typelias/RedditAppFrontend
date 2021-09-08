class RedditPost {
  final String subreddit;
  final String? text;
  final String title;
  final String img;
  final String fullName;
  final String authorName;
  final List<String>? galleryImages;
  final String permaLink;

  RedditPost({
    required this.subreddit,
    required this.text,
    required this.title,
    required this.img,
    required this.fullName,
    required this.authorName,
    required this.galleryImages,
    required this.permaLink,
  });

  factory RedditPost.fromJson(dynamic json) {
    List<String> gal = [];

    if(json['gallery'] != null) {
      var jsonUrl = json['gallery'] as List;
      List<String> gal = jsonUrl.map((e) => e.toString()).toList();
    } else {
      var gal = [];
    }
    return RedditPost(
      subreddit: json['subreddit'] as String,
      text: json['selftext'] as String,
      title: json['title'] as String,
      img: json['url'] as String,
      fullName: json['name'] as String,
      authorName: json['authorName'] as String,
      galleryImages: gal,
      permaLink: json['permaLink'] as String,
    );
  }
}
