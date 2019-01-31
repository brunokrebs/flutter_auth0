import 'package:flutter/material.dart';
import 'package:flutter_auth0/bloc/app_bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloc appBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
          .appBloc;

  AppProvider({Key key, AppBloc appBloc, Widget child})
      : this.appBloc = appBloc ?? AppBloc(),
        super(child: child, key: key);
}
