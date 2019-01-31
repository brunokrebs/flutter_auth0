import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_auth0/utils/url_utils.dart'
    show DOMAIN, REDIRECT_URI, CLIENT_ID, codeVerifier;

class AccessBloc {
  Stream<User> _output = Stream.empty();
  ReplaySubject<String> _authCodeInput =
      ReplaySubject<String>(); //accept the auth code

  Stream<User> get output => _output;
  Sink<String> get authCodeInput => _authCodeInput;

  AccessBloc() {
    _output = _authCodeInput.distinct().asyncMap(doAction).asBroadcastStream();
  }

  /// To get the accessToken and use it to query the API
  Future<User> doAction(String authCode) async {
    User user;
    String accessToken;
    await getAccessCode(authCode).then((tokenValue) {
      accessToken = tokenValue;
    }).whenComplete(() async{
      await getUserDetails(accessToken).then((userValue){
        user = userValue;
      });
    });
    return user;
  }

  /// To get the access token
  Future<String> getAccessCode(String authCode) async {
    String accessCode = "";
    var url = "https://$DOMAIN/oauth/token";
    final response = await http.post(url, body: {
      "grant_type": "authorization_code",
      "client_id": CLIENT_ID,
      "code_verifier": codeVerifier,
      "code": authCode,
      "redirect_uri": REDIRECT_URI,
    });

    if (response.statusCode == 200) {
      Map jsonMap = json.decode(response.body);
      print("\n\nThe response body is ${response.body}\n\n");
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
}

class User {
  final String pictureUrl;
  final String name;
  final String nickname;


  User({this.pictureUrl, this.name, this.nickname});
}
