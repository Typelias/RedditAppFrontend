import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Providers/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var loading = true;

  Future<bool> checkLogin() async {
    return Provider.of<User>(context, listen: false).getToken();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      checkLogin().then((value) {
        if (!value) {
          Navigator.of(context).pushNamed("/login");
          loading = false;
          return;
        }
      });
    }


    loading = false;
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yes"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text("Hej"),
            ),
    );
  }
}
