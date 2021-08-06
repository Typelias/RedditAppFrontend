import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_frontend/Providers/user.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/login";
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide a value";
                    }
                    return null;
                  },
                  onSaved: (String? val) {
                    username = val.toString();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide a value";
                    }
                    return null;
                  },
                  onSaved: (String? val) {
                    password = val.toString();
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    if (_formKey.currentState!.validate()) {
                      Provider.of<User>(context, listen: false).setUser(username, password);
                      Provider.of<User>(context, listen: false).doLogin();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
