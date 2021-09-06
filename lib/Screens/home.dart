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


  void redditLogin() async {

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

  logout() {
    Provider.of<User>(context, listen: false).doLogOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
        title: Text("Yes"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  Text("Hej"),
                  ElevatedButton(onPressed: () {
                    var token = Provider.of<User>(context, listen: false).token;
                    print(token);
                    print("hello");
                    print(Provider.of<User>(context, listen: false).username);
                  }, child: Text('Greger'))
                ],
              ),
            ),
    );
  }
}
