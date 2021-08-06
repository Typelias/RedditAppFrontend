import 'package:flutter/material.dart';
import 'package:reddit_frontend/Providers/home.dart';
import 'package:reddit_frontend/Providers/user.dart';
import 'package:reddit_frontend/Screens/LoginScreen.dart';
import 'package:provider/provider.dart';

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
        )
      ],
      child: MaterialApp(
        title: "Best Reddit App",
        home: HomeScreen(),
        routes: {
          LoginScreen.routName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
