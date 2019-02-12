import 'package:flutterapp/rebloc/models/enums.dart';
import 'package:flutterapp/rebloc/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final User user;

  const ProfileState({
    this.user,
  });

  ProfileState.initialState()
      : user = User(name: "", nickname: "", pictureUrl: "");

  ProfileState copyWith({User user}) {
    return ProfileState(
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return "ProfileState_$user";
  }
}
