import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/image.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:cyber_friend_circle/screens/friend_management/friend_management_state.dart';
import 'package:cyber_friend_circle/screens/friend_management/new_friend_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

/// 管理朋友的相关状态通知器
class FriendManagementNotifier
    extends AutoDisposeNotifier<FriendManagementState> {
  /// 数据库实例
  final IsarDatabase database = IsarDatabase();

  @override
  /// 构建初始状态
  FriendManagementState build() {
    // 获取所有非用户类型（即朋友类型）的用户
    final users = database.isar!.users
        .filter()
        .not()
        .typeEqualTo(UserType.you)
        .findAllSync();

    // 返回初始状态，包含朋友列表
    return FriendManagementState(friends: users);
  }

  /// 刷新状态
  refresh() {
    // 同build方法，重新获取所有非用户类型（即朋友类型）的用户
    final users = database.isar!.users
        .filter()
        .not()
        .typeEqualTo(UserType.you)
        .findAllSync();

    // 更新状态，设置新的朋友列表
    state = state.copyWith(friends: users);
  }

  /// 添加角色标签给指定用户
  addCharacters(User u, String tag) async {
    // 开始数据库写事务
    await database.isar!.writeTxn(() async {
      // 给用户添加新的角色标签
      u.characters = List.of(u.characters)..add(tag);
      // 更新用户数据
      await database.isar!.users.put(u);
    });

    // 刷新状态
    refresh();
  }

  /// 移除指定用户的角色标签
  removeCharacters(User u, String tag) async {
    // 开始数据库写事务
    await database.isar!.writeTxn(() async {
      // 移除用户的角色标签
      u.characters = List.of(u.characters)..remove(tag);
      // 更新用户数据
      await database.isar!.users.put(u);
    });

    // 刷新状态
    refresh();
  }

  /// 添加新朋友
  addFriend(NewFriendState n) async {
    // 创建新用户对象，并设置其属性
    final User u = User()
      ..avatar = n.url
      ..avatarType = ImageType.asset
      ..characters = n.characters.toList()
      ..name = n.name
      ..type = UserType.friend
      ..personalTagline = n.signature;

    // 开始数据库写事务，添加新朋友
    await database.isar!.writeTxn(() async {
      // 将新朋友添加到数据库
      await database.isar!.users.put(u);
    });

    // 刷新状态
    refresh();
  }
}


final friendManagementProvider = AutoDisposeNotifierProvider<
    FriendManagementNotifier,
    FriendManagementState>(FriendManagementNotifier.new);
