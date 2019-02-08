import 'package:flutterapp/rebloc/bloc/auth_bloc.dart';
import 'package:flutterapp/rebloc/bloc/main_bloc.dart';
import 'package:flutterapp/rebloc/bloc/profile_bloc.dart';
import 'package:flutterapp/rebloc/state/app_state.dart';
import 'package:rebloc/rebloc.dart';

final appStore = Store<AppState>(
  initialState: AppState.initialState(),
  blocs: [
    MainBloc(),
    AuthBloc(),
    ProfileBloc(),
  ],
);
