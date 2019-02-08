import 'package:flutterapp/rebloc/models/enums.dart'; 
import 'package:flutterapp/rebloc/models/user.dart'; 
import 'package:meta/meta.dart'; 

@immutable
class ProfileState {
  final User user; 
  final LoadingStatus loadingStatus; 

  const ProfileState( {
    this.user, 
    this.loadingStatus, 
  }); 

  ProfileState.initialState():user = User(name:"", nickname:"", pictureUrl:""), 
        loadingStatus = LoadingStatus.LOADING; 

  ProfileState copyWith( {User user, LoadingStatus loadingStatus}) {
    return ProfileState(
      user:user??this.user, 
      loadingStatus:loadingStatus??this.loadingStatus, 
    ); 
  }

  @override
  String toString() {
    return "ProfileState_$user$loadingStatus"; 
  }
}
