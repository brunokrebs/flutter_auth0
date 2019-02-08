import 'dart:async';
import 'dart:convert';

import 'package:flutterapp/rebloc/actions/profile_actions.dart';
import 'package:flutterapp/rebloc/models/user.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/utils/persistence.dart';
import 'package:http/http.dart' as http;
import 'package:rebloc/rebloc.dart';
import 'package:flutterapp/utils/url_utils.dart'
    show DOMAIN, REDIRECT_URI, CLIENT_ID, codeVerifier;

class ProfileBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(
    DispatchFunction dispatch,
    AppState state,
    Action action,
  ) async {
    if (action is GetNewTokensAction) {
      String accessToken;
      await getNewTokens(action.authCode).then((tokenValue) {
        accessToken = tokenValue;
      }).whenComplete(() async {
        await getUserDetails(accessToken).then((user) {
          dispatch(DisplayDetailsAction(user: user));
        });
      });
    }
    if (action is GetAccessFromRefreshTokenAction) {
      String accessToken;
      await getAccessFromRefreshTokens(action.refreshToken).then((tokenValue) {
        accessToken = tokenValue;
      }).whenComplete(() async {
        await getUserDetails(accessToken).then((user) {
          dispatch(DisplayDetailsAction(user: user));
        });
      });
    }
    return super.middleware(dispatch, state, action);
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _profileState = state.profileState;
    if (action is DisplayDetailsAction) {
      return state.copyWith(
          profileState: _profileState.copyWith(user: action.user));
    }
    return state;
  }
}

///MAKE SURE YO PASSING NECESSARY PARAMETERS
/// To get the access token and refresh token using auth code
Future<String> getNewTokens(String authCode) async {
  String accessToken = "";
  String refreshToken = "";
  var url = "https://$DOMAIN/oauth/token";
  final response = await http.post(url, body: {
    "grant_type": "authorization_code",
    "client_id": CLIENT_ID,
    "code_verifier": codeVerifier,
    "code": authCode,
    "redirect_uri": REDIRECT_URI,
  });
  print("\n\n\nThe received access token response is ${response.body}\n\n\n");
  if (response.statusCode == 200) {
    Map jsonMap = json.decode(response.body);
    accessToken = jsonMap['access_token'];
    refreshToken = jsonMap['refresh_token'];
    await storeRefreshToken(refreshToken: refreshToken);
    print("The refresh token is $refreshToken\n\n\n");
    print("The access token is $accessToken\n\n\n");
  } else {
    throw Exception('Failed to get access token');
  }
  return accessToken;
}

//To get access token from refresh token
///CHANGE NECESSARY PARAMETERS
Future<String> getAccessFromRefreshTokens(String refreshToken) async {
  String accessCode = "";
  var url = "https://$DOMAIN/oauth/token";
  final response = await http.post(url, body: {
    "grant_type": "refresh_token",
    "client_id": CLIENT_ID,
    "refresh_token": refreshToken,
  });
  print("\n\n\nThe received access token response is ${response.body}\n\n\n");
  if (response.statusCode == 200) {
    Map jsonMap = json.decode(response.body);
    accessCode = jsonMap['access_token'];
  } else {
    throw Exception('Failed to get access token');
  }
  return accessCode;
}

/// To get the user details from userinfo API of identity provider
Future<User> getUserDetails(String accessToken) async {
  User user;
  var url = "https://$DOMAIN/userinfo";
  final response =
      await http.get(url, headers: {"authorization": "Bearer $accessToken"});
  print("\n\n\nThe received user details response is ${response.body}\n\n\n");
  if (response.statusCode == 200) {
    Map jsonMap = json.decode(response.body);
    var name = jsonMap['name'];
    var pictureUrl = jsonMap['picture'];
    var nickname = jsonMap['nickname'];
    user = User(
      name: name,
      pictureUrl: pictureUrl,
      nickname: nickname,
    );
  } else {
    throw Exception('Failed to get user details');
  }
  return user;
}
