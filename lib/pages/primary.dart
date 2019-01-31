import 'package:flutter/material.dart';
import 'package:flutter_auth0/bloc/access_bloc.dart';
import 'package:flutter_auth0/bloc/auth_bloc.dart';
import 'package:flutter_auth0/bloc/app_provider.dart';
import 'package:flutter_auth0/pages/home.dart';
import 'package:flutter_auth0/pages/login.dart';

class Primary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AppProvider.of(context).authBloc;
    AccessBloc accessBloc = AppProvider.of(context).accessBloc;
    return StreamBuilder(
      stream: authBloc.output,
      builder: (BuildContext context, AsyncSnapshot<CodeModel> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data.valueType == "code") {
            accessBloc.authCodeInput.add(snapshot.data.authCode);
            return Home(); //log user in if user grants access
          } else {
            return Login(
                error: snapshot.data
                    .authCode); //return error page if user doesn't grant access
          }
        }
        return Login();
      },
    );
  }
}
