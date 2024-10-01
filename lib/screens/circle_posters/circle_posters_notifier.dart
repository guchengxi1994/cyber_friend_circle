import 'dart:math';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/image.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'circle_posters_state.dart';

// CirclePostersNotifier类用于管理圆形海报的状态，包括与数据库的交互
class CirclePostersNotifier extends AutoDisposeNotifier<CirclePostersState> {
  final database = IsarDatabase();

  @override
  CirclePostersState build() {
    // 初始化时从数据库获取最新的10个主题
    final topics = database.isar!.topics
        .where()
        .sortByCreateAtDesc()
        .limit(10)
        .findAllSync();

    return CirclePostersState(topics: topics);
  }

  /// 插入测试数据
  ///
  /// 此方法用于在数据库中插入一系列测试数据，包括用户、主题和回复
  /// TODO remove later
  Future insertTestData() async {
    // 创建并初始化测试用户
    final user = User()
      ..id = 1
      ..name = "xiaoshuyui"
      ..avatar = "assets/avatars/f1.webp"
      ..type = UserType.you
      ..avatarType = ImageType.asset
      ..personalTagline = "一个努力追求卓越的平常人。";

    final user2 = User()
      ..id = 2
      ..name = "friend"
      ..avatar = "assets/avatars/f2.webp"
      ..type = UserType.friend
      ..avatarType = ImageType.asset
      ..personalTagline = "一个努力追求卓越的平常人。"
      ..characters = [
        "善良的",
        "温和的",
        "开朗的",
        "勇敢的",
        "诚实的",
      ];

    // 创建并初始化测试主题
    final topic = Topic()
      ..content = """
## 今天不加班，好开心

为什么不加班呢？

因为加班没有加班费。😀
"""
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..maxReplyCount = 2;

    // 创建并初始化测试回复
    final TopicReply reply = TopicReply()
      ..content = "😀"
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..replyType = ReplyType.text;

    // 在数据库中写入测试数据
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

  /// 获取测试用户
  ///
  /// 此方法用于获取测试用户对象
  User get user => User()
    ..id = 1
    ..name = "xiaoshuyui"
    ..avatar = "assets/avatars/f1.webp"
    ..type = UserType.you
    ..avatarType = ImageType.asset;

  // 切换底部输入框显示状态
  void toggleBottom() {
    state = state.copyWith(showBottom: !state.showBottom);
  }

  /// 切换背景图片的展开状态
  ///
  /// 此方法通过更改状态中的bgImageExpanded字段，来实现背景图片展开和收起的效果。
  /// 当bgImageExpanded为true时，表示背景图片展开；为false时，表示背景图片收起。
  void changeBgExpand() {
    state = state.copyWith(bgImageExpanded: !state.bgImageExpanded);
  }

  // 切换输入框展开状态
  void changeInputExpand(bool b) {
    state = state.copyWith(inputExpaned: b);
  }

  final Random random = Random();

  /**
   * 异步发布新主题
   *
   * 此函数用于创建并发布一个新的主题到数据库中同时更新状态
   * 它首先初始化一个Topic对象，设置内容为传入的字符串s，
   * 创建时间为当前时间，最大回复数为一个随机数加一然后在数据库中写入该主题
   * 最后更新状态，将新主题添加到主题列表的开头，并设置showBottom为false
   *
   * @param s 主题的内容字符串
   */
  Future postNewTopic(String s) async {
    // 初始化一个Topic对象，并用传入的内容、当前时间以及一个随机的最大回复数进行配置
    final topic = Topic()
      ..content = s
      ..createAt = DateTime.now().millisecondsSinceEpoch
      ..maxReplyCount = random.nextInt(5) + 1;

    // 在数据库中写入新的主题
    await database.isar!.writeTxn(() async {
      await database.isar!.topics.put(topic);
    });

    // 更新状态，将新主题添加到主题列表的开头，并设置showBottom为false
    state = state.copyWith(topics: [topic, ...state.topics], showBottom: false);
  }

  // 刷新主题列表
  refresh() {
    // 从数据库重新获取最新的10个主题并更新状态
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
