import 'package:flutterapp/rebloc/models/user.dart';
import 'package:rebloc/rebloc.dart';

class DisplayDetailsAction extends Action {
  final User user;

  const DisplayDetailsAction({this.user});
}

class GetTokensFromAuthAction extends Action {
  final String authCode;

  const GetTokensFromAuthAction({this.authCode});
}

class GetAccessFromRefreshTokenAction extends Action{
  final String refreshToken;

  const GetAccessFromRefreshTokenAction({this.refreshToken});
}


