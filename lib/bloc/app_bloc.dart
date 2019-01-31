import 'package:flutter_auth0/bloc/access_bloc.dart';
import 'package:flutter_auth0/bloc/auth_bloc.dart';

class AppBloc { 
  AuthBloc _authBloc; 
  AccessBloc _accessBloc; 

  AppBloc() {
    _authBloc = AuthBloc(); 
    _accessBloc = AccessBloc(); 
  }

  AuthBloc get authBloc => _authBloc; 
  AccessBloc get accessBloc => _accessBloc; 

}
