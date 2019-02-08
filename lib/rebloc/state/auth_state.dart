import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:flutterapp/rebloc/models/auth_model.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final AuthModel authModel;
  final LoadingStatus loadingStatus;

  const AuthState({this.loadingStatus, this.authModel});

  AuthState.initial()
      : authModel = AuthModel(
          isAuthenticated: false,
          authCode: "",
        ),
        loadingStatus = LoadingStatus.SUCCESSFUL;

  AuthState copyWith({AuthModel authModel, LoadingStatus loadingStatus}) {
    return AuthState(
      authModel: authModel ?? this.authModel,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "AuthState_$authModel$loadingStatus";
  }
}
