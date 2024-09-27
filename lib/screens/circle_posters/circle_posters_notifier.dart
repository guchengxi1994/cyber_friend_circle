import 'dart:math';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/image.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'circle_posters_state.dart';

class CirclePostersNotifier extends AutoDisposeNotifier<CirclePostersState> {
  final database = IsarDatabase();

  @override
  CirclePostersState build() {
    final topics = database.isar!.topics
        .where()
        .sortByCreateAtDesc()
        .limit(10)
        .findAllSync();

    return CirclePostersState(topics: topics);
  }

  /// FOR TEST
  ///
  /// Insert some test data
  Future insertTestData() async {
    final user = User()
      ..id = 1
      ..name = "xiaoshuyui"
      ..avatar = "assets/avatars/f1.webp"
      ..type = UserType.you
      ..avatarType = ImageType.asset;

    final user2 = User()
      ..id = 2
      ..name = "friend"
      ..avatar = "assets/avatars/f2.webp"
      ..type = UserType.friend
      ..avatarType = ImageType.asset;

    final topic = Topic()
      ..content = """
## 今天不加班，好开心

为什么不加班呢？

因为加班没有加班费。😀
"""
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..maxReplyCount = 2;

    final TopicReply reply = TopicReply()
      ..content = "😀"
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..replyType = ReplyType.text;

    await database.isar!.writeTxn(() async {
      await database.isar!.users.put(user);
      await database.isar!.users.put(user2);
      await database.isar!.topics.put(topic);
      await database.isar!.topicReplys.put(reply);
      topic.replies.add(reply);
      reply.user.value = user2;
      await topic.replies.save();
      await reply.user.save();
      await database.isar!.topics.put(topic);
      await database.isar!.topicReplys.put(reply);
    });
  }

  /// TODO remove this test data
  User get user => User()
    ..id = 1
    ..name = "xiaoshuyui"
    ..avatar = "assets/avatars/f1.webp"
    ..type = UserType.you
    ..avatarType = ImageType.asset;

  void toggleBottom() {
    state = state.copyWith(showBottom: !state.showBottom);
  }

  void changeBgExpand() {
    state = state.copyWith(bgImageExpanded: !state.bgImageExpanded);
  }

  void changeInputExpand(bool b) {
    state = state.copyWith(inputExpaned: b);
  }

  final Random random = Random();

  Future postNewTopic(String s) async {
    final topic = Topic()
      ..content = s
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..maxReplyCount = random.nextInt(5) + 1;

    await database.isar!.writeTxn(() async {
      await database.isar!.topics.put(topic);
    });

    state = state.copyWith(topics: [topic, ...state.topics], showBottom: false);
  }

  refresh() {
    state = state.copyWith(
      topics: database.isar!.topics
          .where()
          .sortByCreateAtDesc()
          .limit(10)
          .findAllSync(),
    );
  }
}

final circlePostersProvider =
    AutoDisposeNotifierProvider<CirclePostersNotifier, CirclePostersState>(
  CirclePostersNotifier.new,
);
