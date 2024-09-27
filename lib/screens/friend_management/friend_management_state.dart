import 'package:cyber_friend_circle/isar/user.dart';

class FriendManagementState {
  final List<User> friends;

  FriendManagementState({this.friends = const []});

  FriendManagementState copyWith({List<User>? friends}) {
    return FriendManagementState(friends: friends ?? this.friends);
  }
}
