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

  refresh() {
    final users = database.isar!.users
        .filter()
        .not()
        .typeEqualTo(UserType.you)
        .findAllSync();

    state = state.copyWith(friends: users);
  }

  addCharacters(User u, String tag) async {
    await database.isar!.writeTxn(() async {
      u.characters = List.of(u.characters)..add(tag);
      await database.isar!.users.put(u);
    });

    refresh();
  }

  removeCharacters(User u, String tag) async {
    await database.isar!.writeTxn(() async {
      u.characters = List.of(u.characters)..remove(tag);
      await database.isar!.users.put(u);
    });

    refresh();
  }
}

final friendManagementProvider = AutoDisposeNotifierProvider<
    FriendManagementNotifier,
    FriendManagementState>(FriendManagementNotifier.new);
