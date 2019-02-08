import 'package:flutterapp/rebloc/models/user.dart';
import 'package:rebloc/rebloc.dart';

class DisplayDetailsAction extends Action {
  final User user;

  const DisplayDetailsAction({this.user});
}

class GetNewTokensAction extends Action {
  final String authCode;

  const GetNewTokensAction({this.authCode});
}

class GetAccessFromRefreshTokenAction extends Action{
  final String refreshToken;

  const GetAccessFromRefreshTokenAction({this.refreshToken});
}


