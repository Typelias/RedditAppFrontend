import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Providers/CurrentPost.dart';

class ActivePost extends StatelessWidget {
  const ActivePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentPost = Provider.of<CurrentPost>(context).currentPost;

    return currentPost != null
        ? Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          currentPost.title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          "r/" + currentPost.subreddit,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(currentPost.text!),
                        if (currentPost.img.contains(".jpg") ||
                            currentPost.img.contains(".png") ||
                            currentPost.img.contains(".gif"))
                          Image.network(
                            currentPost.img,
                            height: 500,
                            fit: BoxFit.contain,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Text("No post selected");
  }
}
