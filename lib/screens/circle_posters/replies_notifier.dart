import 'dart:async';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

/**
 * RepliesNotifier 类用于管理主题回复的相关状态，继承自
 * AutoDisposeFamilyAsyncNotifier，该类专门处理基于主题ID异步加载回复列表的逻辑。
 */
class RepliesNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<TopicReply>, int> {
  // 初始化Isar数据库实例，用于后续的数据操作。
  final database = IsarDatabase();

  /**
   * 构建方法，用于异步加载指定主题的回复列表。
   *
   * @param arg 主题的唯一标识符（ID）。
   * @return 返回该主题下的回复列表。
   */
  @override
  FutureOr<List<TopicReply>> build(int arg) async {
    // 通过数据库查询指定ID的主题，并获取其第一个结果。
    final topic =
        (await database.isar!.topics.filter().idEqualTo(arg).findAll()).first;

    // 将查询到的主题下的回复转换为列表并返回。
    return topic.replies.toList();
  }

  /**
   * 更新回复方法，用于将修改后的回复对象保存到数据库。
   *
   * @param reply 需要更新的回复对象。
   */
  updateReply(TopicReply reply) async {
    // 在数据库事务中更新回复对象，确保数据一致性。
    await database.isar!.writeTxn(() async {
      await database.isar!.topicReplys.put(reply);
    });

    // 更新开始，设置状态为加载中。
    state = AsyncLoading();

    // 重新加载更新后的回复列表，更新状态。
    state = await AsyncValue.guard(() async {
      // 重新查询数据库以获取更新后的回复列表。
      final topic =
          (await database.isar!.topics.filter().idEqualTo(arg).findAll()).first;

      return topic.replies.toList();
    });
  }
}


final repliesProvider = AutoDisposeAsyncNotifierProvider.family<RepliesNotifier,
    List<TopicReply>, int>(RepliesNotifier.new);
