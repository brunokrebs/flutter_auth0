import 'package:flutterapp/rebloc/models/auth_model.dart';
import 'package:meta/meta.dart';


@immutable
class AuthState {
  final AuthModel authModel;

  const AuthState({this.authModel});

  AuthState.initial()
      : authModel = AuthModel(
          isAuthenticated: false,
          authCode: "",
        );

  AuthState copyWith({AuthModel authModel}) {
    return AuthState(
      authModel: authModel ?? this.authModel,
    );
  }

  @override
  String toString() {
    return "AuthState_$authModel";
  }
}
