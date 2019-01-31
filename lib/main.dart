import 'package:flutter/material.dart';
import 'package:flutter_auth0/bloc/app_bloc.dart';
import 'package:flutter_auth0/bloc/app_provider.dart';
import 'package:flutter_auth0/pages/primary.dart';

void main() {
  AppBloc appBloc = AppBloc();
  runApp(MyApp(appBloc: appBloc));
}

class MyApp extends StatelessWidget {
  final AppBloc appBloc;
  const MyApp({Key key, this.appBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      appBloc: appBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Primary(),
      ),
    );
  }
}
