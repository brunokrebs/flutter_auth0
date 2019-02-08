import 'package:flutter/material.dart';
import 'package:flutterapp/rebloc/actions/auth_actions.dart';
import 'package:flutterapp/rebloc/models/auth_model.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/utils/auth_utils.dart';
import 'package:flutterapp/utils/url_utils.dart' show getAuthorizationUrl;
import 'package:rebloc/rebloc.dart';

class Login extends StatelessWidget {
  final String loginError;

  const Login({Key key, this.loginError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, AuthModel>(
        converter: (state) => state.authState.authModel,
        builder: (context, dispatch, viewModel) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      launchURL(
                        context,
                        url: getAuthorizationUrl(),
                      );
                      dispatch(GetReceivedURLAction());
                    },
                    child: Text("Click to Login"),
                  ),
                  loginError != null ? Text(loginError) : Text(""),
                ],
              ),
            ),
          );
        });
  }
}
