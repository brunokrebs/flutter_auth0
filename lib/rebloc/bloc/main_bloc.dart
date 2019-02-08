import 'dart:async';

import 'package:flutterapp/rebloc/actions/auth_actions.dart';
import 'package:flutterapp/rebloc/actions/main_actions.dart';
import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/rebloc/state/main_state.dart';
import 'package:flutterapp/utils/persistence.dart';
import 'package:rebloc/rebloc.dart';

class MainBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(
    DispatchFunction dispatcher,
    AppState state,
    Action action,
  ) async {
    if (action is OnInitAction) {
      await getRefreshToken().then((refreshToken) {
        print("The retrieved refresh token is $refreshToken \n\n\n");
        if (refreshToken != null && refreshToken.isNotEmpty) {
          dispatcher(SilentLoginAction(refreshToken: refreshToken));
        }
      });
    }
    return super.middleware(dispatcher, state, action);
  }

  @override
  AppState reducer(AppState state, Action action) {
    final _mainState = state.mainState;
    if (action is OnInitAction) {
      return state.copyWith(
        mainState: _mainState.copyWith(newScreenType: ScreenType.loggedOut),
      );
      // final hasToken = false;

      // if (hasToken) {
      //   return state.copyWith(
      //     mainState: _mainState.copyWith(newScreenType: ScreenType.loggedIn),
      //   );
      // } else {
      //   return state.copyWith(
      //     mainState: _mainState.copyWith(newScreenType: ScreenType.loggedOut),
      //   );
      // }
    }
    if (action is SilentLoginAction) {
      return state.copyWith(
        mainState: _mainState.copyWith(
            newScreenType: ScreenType.loggedIn,
            refreshToken: action.refreshToken),
      );
    }
    return state;
  }
}
