import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Providers/user.dart';
import 'package:webview_windows/webview_windows.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class RedditLoginScreen extends StatefulWidget {
  static const routename = "/redditLogin";

  @override
  _RedditLoginScreenState createState() => _RedditLoginScreenState();
}

class _RedditLoginScreenState extends State<RedditLoginScreen> {
  final _controller = WebviewController();
  final _textController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    _controller.url.listen((url) {
      print(url);
      if (url.contains("&code=")) {
        _textController.text = url;
        print("Greger");
        var start = url.lastIndexOf("code=");
        var code = url.substring(start + 5, url.length - 2);
        loading = true;
        Provider.of<User>(context, listen: false)
            .doLogin(code)
            .then((value) => Navigator.of(context).pop());
      }
    });

    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.loadUrl(
        'https://www.reddit.com/api/v1/authorize?client_id=kEVB3v54wz-xD9C94bWGnA&response_type=code&state=RANDOM_STRING&redirect_uri=https://github.com/Typelias/RedditAppFrontend&duration=permanent&scope=*');

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: _controller.title,
          builder: (context, snapshot) {
            return Text(snapshot.hasData
                ? snapshot.data!
                : 'WebView (Windows) Example');
          },
        ),
      ),
      body: loading
          ? CircularProgressIndicator()
          : Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Expanded(
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Webview(
                          _controller,
                          permissionRequested: _onPermissionRequested,
                        ),
                        StreamBuilder<LoadingState>(
                            stream: _controller.loadingState,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == LoadingState.loading) {
                                return LinearProgressIndicator();
                              } else {
                                return Container();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}
