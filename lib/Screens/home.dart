import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Classes/RedditListing.dart';
import 'package:reddit_frontend/Providers/CurrentPost.dart';
import 'package:reddit_frontend/Providers/FrontPageListing.dart';
import 'package:reddit_frontend/Providers/user.dart';
import 'package:reddit_frontend/Screens/RedditLogin.dart';
import 'package:reddit_frontend/Screens/test.dart';
import 'package:reddit_frontend/Widgets/ActivePost.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var loading = true;

  Future<bool> checkLogin() async {
    return Provider.of<User>(context, listen: false).checkUser();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      checkLogin().then((value) {
        if (!value) {
          Navigator.of(context).pushNamed(Test.routename);
          return;
        }
        Provider.of<User>(context, listen: false).getToken.then((value) {
          Provider.of<FrontPageListing>(context, listen: false)
              .init(value)
              .then((val) {
            loading = false;
          });
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  logout() {
    Provider.of<User>(context, listen: false).doLogOut();
  }

  @override
  Widget build(BuildContext context) {
    final postList = Provider.of<FrontPageListing>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
        title: Text(Provider.of<User>(context).username),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Text(
                              postList.redditListing!.postList[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(postList
                                .redditListing!.postList[index].subreddit),
                          ],
                        ),
                        onTap: () {
                          Provider.of<CurrentPost>(context, listen: false)
                              .current(postList.redditListing!.postList[index]);
                        },
                      );
                    },
                    itemCount: postList.redditListing!.postList.length,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ActivePost(),
                ),
              ],
            ),
    );
  }
}
