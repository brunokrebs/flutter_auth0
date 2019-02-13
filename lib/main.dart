import 'package:flutter/material.dart';
import 'package:flutterapp/rebloc/actions/main_actions.dart';
import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:flutterapp/rebloc/store.dart';
import 'package:flutterapp/screens/login.dart';
import 'package:flutterapp/screens/profile.dart';
import 'package:flutterapp/widgets/appbar.dart';
import 'package:rebloc/rebloc.dart';

void main() {
  runApp(StoreProvider<AppState>(
    store: appStore,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FirstBuildDispatcher<AppState>(
        action: OnInitAction(),
        child: ViewModelSubscriber<AppState, AppState>(
          converter: (state) => state,
          builder: (context, dispatcher, viewModel) {
            if (viewModel.mainState.screenType == ScreenType.loggedIn) {
              String refreshToken = viewModel.mainState.refreshToken;
              return Profile(
                code: refreshToken,
                isAuthCode: false, 
              );
            } else {
              bool isAuthenticated =
                  viewModel.authState.authModel.isAuthenticated;
              String code = viewModel.authState.authModel.authCode;
              if (isAuthenticated) {
                return Profile(
                  code: code,
                  isAuthCode: true,
                );
              } else if (isAuthenticated == false) {
                return Login(
                  loginError: code,
                );
              }
            }
            return Login();
          },
        ),
      ),
    );
  }
}
