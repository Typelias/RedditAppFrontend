import 'package:flutter/material.dart';
import 'package:reddit_frontend/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Hello World!'),
              TextButton(
                onPressed: () {

                },
                child: Text("Send request"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
