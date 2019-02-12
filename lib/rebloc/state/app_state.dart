import 'package:flutterapp/rebloc/state/auth_state.dart'; 
import 'package:flutterapp/rebloc/state/main_state.dart'; 
import 'package:flutterapp/rebloc/state/profile_state.dart';
import 'package:meta/meta.dart'; 


@immutable
class AppState {
  final MainState mainState; 
  final AuthState authState; 
  final ProfileState profileState; 

  const AppState( {this.mainState, this.authState, this.profileState}); 

  AppState.initialState():mainState = MainState.initialState(), 
        authState = AuthState.initial(), 
        profileState = ProfileState.initialState(); 

  AppState copyWith( {MainState mainState, AuthState authState, ProfileState profileState}) {
    return AppState(
      mainState:mainState??this.mainState, 
      authState:authState??this.authState, 
      profileState:profileState??this.profileState, 
    ); 
  }

  @override
  String toString() => "AppState_$mainState$authState$profileState"; 
}
