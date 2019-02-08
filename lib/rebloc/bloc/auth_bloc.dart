import 'dart:async';

import 'package:flutterapp/rebloc/actions/auth_actions.dart';
import 'package:flutterapp/rebloc/models/auth_model.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/utils/persistence.dart';
import 'package:rebloc/rebloc.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

class AuthBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(
    DispatchFunction dispatch,
    AppState state,
    Action action,
  ) async {
    if (action is GetReceivedURLAction) {
      StreamSubscription _sub;
      String receivedLink;

      try {
        receivedLink = await getInitialLink();
        _sub = getLinksStream().listen(
          (String link) {
            receivedLink = link;

            print("The received link is $receivedLink");
            if (receivedLink.startsWith("myapp://logincallback")) {
              AuthModel authDetails = parseUrlToValue(receivedLink);
              dispatch(LoginAction(
                  authCode: authDetails.authCode,
                  isAuthenticated: authDetails.isAuthenticated));
            } else if (receivedLink.startsWith("myapp://logoutcallback")) {
              dispatch(LogoutAction());
            }
          },
          onError: (err) {
            receivedLink = err;
          },
          onDone: () {
            _sub.cancel();
          },
        );
      } on PlatformException {}
    }

    if (action is LogoutAction) {
      await deleteRefreshToken();
    }

    return super.middleware(dispatch, state, action);
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _authState = state.authState;
    if (action is LoginAction) {
      return state.copyWith(
        authState: _authState.copyWith(
          authModel: AuthModel(
              authCode: action.authCode,
              isAuthenticated: action.isAuthenticated),
        ),
      );
    }

    if (action is LogoutAction) {
      return AppState.initialState();
    }
    return state;
  }
}

AuthModel parseUrlToValue(String receivedURL) {
  String value;
  bool isAuthenticated = false;
  if (!receivedURL.contains("state")) {
    if (receivedURL.contains("code")) {
      value = receivedURL.substring(receivedURL.lastIndexOf("?code=") + 6);
      isAuthenticated = true;
    } else if (receivedURL.contains("error")) {
      value = receivedURL.substring(receivedURL.lastIndexOf("?error=") + 7);
    }
  } else {
    if (receivedURL.contains("code")) {
      value = receivedURL.substring(
          receivedURL.lastIndexOf("?code=") + 6, receivedURL.indexOf("&state"));
      isAuthenticated = true;
    } else if (receivedURL.contains("error")) {
      value = receivedURL.substring(receivedURL.lastIndexOf("?error=") + 7);
    }
  }
  return AuthModel(isAuthenticated: isAuthenticated, authCode: value);
}
