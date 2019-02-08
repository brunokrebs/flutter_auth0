import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:meta/meta.dart';

@immutable
class MainState {
  final ScreenType screenType;
  final String refreshToken;
  const MainState({this.screenType, this.refreshToken});

  MainState.initialState()
      : screenType = ScreenType.loggedOut,
        refreshToken = "";

  MainState copyWith({
    ScreenType newScreenType,
    String refreshToken,
  }) {
    return MainState(
      screenType: newScreenType,
      refreshToken: refreshToken,
    );
  }

  @override
  String toString() => "MainState_$screenType";
}

