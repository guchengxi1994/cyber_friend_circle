import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:cyber_friend_circle/screens/friend_management/friend_management_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class FriendManagementNotifier
    extends AutoDisposeNotifier<FriendManagementState> {
  final IsarDatabase database = IsarDatabase();

  @override
  FriendManagementState build() {
    final users = database.isar!.users
        .filter()
        .not()
        .typeEqualTo(UserType.you)
        .findAllSync();

    return FriendManagementState(friends: users);
  }
}

final friendManagementProvider = AutoDisposeNotifierProvider<
    FriendManagementNotifier,
    FriendManagementState>(FriendManagementNotifier.new);
