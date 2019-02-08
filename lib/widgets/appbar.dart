import 'package:flutter/material.dart';
import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/rebloc/state/main_state.dart';
import 'package:rebloc/rebloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  Widget build(BuildContext context) {
    return AppBar(
      title: ViewModelSubscriber<AppState, AppState>(
        converter: (state) => state,
        builder: (context, dispatcher, viewModel) {
          return Text(
            viewModel.mainState.screenType == ScreenType.loggedIn ||
                    viewModel.authState.authModel.isAuthenticated
                ? "User Profile"
                : "Welcome",
          );
        },
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => null;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
