import 'dart:math';

import 'package:cyber_friend_circle/global/global.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

import 'user.dart';

part 'topic.g.dart';

enum ReplyType { text, image, animatedEmoji, emoji }

enum Reaction { like, dislike, none }

@collection
class Topic {
  Id id = Isar.autoIncrement;
  String? content;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  int maxReplyCount = 1;
  bool done = false;

  IsarLinks<TopicReply> replies = IsarLinks<TopicReply>();

  bool containsUserStrict(User user) {
    return replies.any((element) =>
        element.user.value == user && element.replyType == ReplyType.text);
  }

  bool containsUser(User user) {
    return replies.any((element) => element.user.value == user);
  }

  @experimental
  List<User> availableUsersStrict(List<User> allUsers) {
    return allUsers.where((element) => !containsUserStrict(element)).toList();
  }

  List<User> availableUsers(List<User> allUsers) {
    return allUsers.where((element) => !containsUser(element)).toList();
  }

  (User, ReplyType)? getAvailableUser(List<User> allUsers) {
    List users = availableUsers(allUsers);
    if (users.isEmpty) {
      List<User> usersStrict = availableUsersStrict(allUsers);
      if (usersStrict.isEmpty) {
        return null;
      }

      List<(User, ReplyType)> cadidates = [];

      for (final i in usersStrict) {
        for (final reply in replies) {
          if (reply.replyType == ReplyType.text) {
            cadidates.add((i, getRandomTypeWithMissing(excludeText: true)));
          } else {
            cadidates.add((i, getReplyType()));
          }
        }
      }

      if (cadidates.isEmpty) {
        return null;
      }

      return cadidates[random.nextInt(cadidates.length)];
    }

    return (users[random.nextInt(users.length)], getReplyType());
  }

  @Ignore()
  final Random random = Random();

  ReplyType getReplyType() {
    double randomValue = random.nextDouble();
    if (randomValue < GlobalSettings.animatedEmojiProportion) {
      return ReplyType.animatedEmoji;
    } else if (randomValue <
        GlobalSettings.animatedEmojiProportion +
            GlobalSettings.emojiProportion) {
      return ReplyType.emoji;
    } else {
      return ReplyType.text;
    }
  }

  // 获取随机类型 (缺少某个类型时调整比例)
  ReplyType getRandomTypeWithMissing(
      {bool excludeAnimatedEmoji = false,
      bool excludeEmoji = false,
      bool excludeText = false}) {
    double totalProportion = 0;
    double animatedEmojiP =
        excludeAnimatedEmoji ? 0 : GlobalSettings.animatedEmojiProportion;
    double emojiP = excludeEmoji ? 0 : GlobalSettings.emojiProportion;
    double textP = excludeText ? 0 : GlobalSettings.textProportion;

    totalProportion = animatedEmojiP + emojiP + textP;

    // 如果没有任何类型可用，抛出异常
    if (totalProportion == 0) {
      throw Exception('No types available');
    }

    // 生成 0 到 totalProportion 之间的随机数
    double randomValue = random.nextDouble() * totalProportion;

    // 根据调整后的比例区间返回对应的类型
    if (randomValue < animatedEmojiP) {
      return ReplyType.animatedEmoji;
    } else if (randomValue < animatedEmojiP + emojiP) {
      return ReplyType.emoji;
    } else {
      return ReplyType.text;
    }
  }
}

@collection
class TopicReply {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? content;

  @enumerated
  ReplyType replyType = ReplyType.text;

  @enumerated
  Reaction reaction = Reaction.none;

  IsarLink<User> user = IsarLink<User>();
}
