import 'package:rebloc/rebloc.dart';

class GetReceivedURLAction extends Action {}



class LoginAction extends Action {
  final String authCode;
  final bool isAuthenticated;

  const LoginAction({this.authCode, this.isAuthenticated});
}

class LogoutAction extends Action {}

class ParseURLtoValue extends Action {
  final String receivedUrl;

  const ParseURLtoValue({this.receivedUrl});
}

class AuthorizeAction extends Action {
  final String authURL;

  const AuthorizeAction({this.authURL});
}

class PersistTokenAction extends Action {
  final String refreshToken;

  const PersistTokenAction({this.refreshToken});
}

class SilentLoginAction extends Action{
  final String refreshToken;

  const SilentLoginAction({this.refreshToken});
}
