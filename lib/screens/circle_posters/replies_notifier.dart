import 'dart:async';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class RepliesNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<TopicReply>, int> {
  final database = IsarDatabase();

  @override
  FutureOr<List<TopicReply>> build(int arg) async {
    final topic =
        (await database.isar!.topics.filter().idEqualTo(arg).findAll()).first;

    return topic.replies.toList();
  }

  updateReply(TopicReply reply) async {
    await database.isar!.writeTxn(() async {
      await database.isar!.topicReplys.put(reply);
    });

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final topic =
          (await database.isar!.topics.filter().idEqualTo(arg).findAll()).first;

      return topic.replies.toList();
    });
  }
}

final repliesProvider = AutoDisposeAsyncNotifierProvider.family<RepliesNotifier,
    List<TopicReply>, int>(RepliesNotifier.new);
