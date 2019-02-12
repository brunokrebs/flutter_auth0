import 'package:flutter/material.dart';
import 'package:flutterapp/rebloc/actions/auth_actions.dart';
import 'package:flutterapp/rebloc/actions/profile_actions.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/rebloc/state/profile_state.dart';
import 'package:flutterapp/utils/auth_utils.dart';
import 'package:flutterapp/widgets/profile_pic.dart';
import 'package:flutterapp/widgets/user_info.dart';
import 'package:flutterapp/utils/url_utils.dart' show DOMAIN;
import 'package:rebloc/rebloc.dart';

class Profile extends StatelessWidget {
  final String code;
  final bool isAuthCode;

  const Profile({Key key, this.code, this.isAuthCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FirstBuildDispatcher<AppState>(
        action: isAuthCode == true
            ? GetTokensFromAuthAction(authCode: code)
            : GetAccessFromRefreshTokenAction(refreshToken: code),
        child: ViewModelSubscriber<AppState, ProfileState>(
          converter: (state) => state.profileState,
          builder: (context, dispatch, viewModel) {
            if (viewModel.user.name == "") {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ProfilePic(
                  pictureURL: viewModel.user.pictureUrl,
                  pictureSize: 150,
                ),
                SizedBox(height: 24.0),
                UserInfoText(
                  label: "name",
                  value: viewModel.user.name,
                ),
                SizedBox(height: 24.0),
                UserInfoText(
                  label: "Nickname",
                  value: viewModel.user.nickname,
                ),
                SizedBox(height: 48.0),
                RaisedButton(
                  onPressed: () {
                    launchURL(
                      context,
                      url: "https://$DOMAIN/v2/logout?returnTo=myapp%3A%2F%2Flogoutcallback",
                    );
                    dispatch(GetReceivedURLAction());
                  },
                  child: Text("Click to Logout"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
