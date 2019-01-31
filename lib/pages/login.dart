import 'package:flutter/material.dart';
import 'package:flutter_auth0/utils/auth_utils.dart';

import 'package:flutter_auth0/utils/url_utils.dart';

class Login extends StatelessWidget {
  final String error;

  const Login({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Auth0"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              error == null
                  ? "Click button below to login"
                  : "An error $error occurred. Tap FAB to retry",
            ),
            SizedBox(height: 24.0),
            RaisedButton(
              onPressed: () {
                getAuthCode(context);
                launchURL(context, url: getAuthorizationUrl());
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
