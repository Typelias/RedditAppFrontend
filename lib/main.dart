import 'package:flutter/material.dart';
import 'package:reddit_frontend/Providers/CurrentPost.dart';
import 'package:reddit_frontend/Providers/FrontPageListing.dart';
import 'package:reddit_frontend/Screens/RedditLogin.dart';
import 'package:reddit_frontend/Screens/home.dart';
import 'package:reddit_frontend/Providers/user.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Screens/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
        ChangeNotifierProvider(
          create: (_) => FrontPageListing(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentPost(),
        )
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        theme: ThemeData.dark(),
        title: "Best Reddit App",
        home: HomeScreen(),
        routes: {
          RedditLoginScreen.routename: (ctx) => RedditLoginScreen(),
          Test.routename: (ctx) => Test(),
        },
      ),
    );
  }
}
