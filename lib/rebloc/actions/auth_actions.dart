import 'package:rebloc/rebloc.dart';

class GetReceivedURLAction extends Action {}

class LoginAction extends Action {
  final String authCode;
  final bool isAuthenticated;

  const LoginAction({this.authCode, this.isAuthenticated});
}

class LogoutAction extends Action {}

class SilentLoginAction extends Action {
  final String refreshToken;

  const SilentLoginAction({this.refreshToken});
}
