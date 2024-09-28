import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:langchain_lib/langchain_lib.dart';

import 'dev_utils.dart';

class IsolateData {
  final SendPort sendPort;
  final RootIsolateToken token;

  IsolateData(this.sendPort, this.token);
}

class AiClient {
  AiClient._();

  static final _instance = AiClient._();

  factory AiClient() => _instance;

  initOpenAi(String path) {
    OpenaiClient.fromEnv(path);
  }

  initOpenAiWithString(String s) {
    OpenaiClient.fromString(s);
  }

  Stream<ChatResult> stream(List<ChatMessage> history,
      {String tag = "text-model"}) {
    final client = OpenaiClient.getByTag(tag);
    return client!.stream(history);
  }

  Future<ChatResult> chat(List<ChatMessage> history,
      {String tag = "text-model"}) async {
    final client = OpenaiClient.getByTag(tag);
    return await client!.invoke(history);
  }
}

// 传出一个需要刷新的topic id
void startIsolate(IsolateData data) async {
  AiClient client = AiClient();
  await client.initOpenAi(DevUtils.env);

  final Random random = Random();
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.token);
  final database = IsarDatabase();

  await database.initialDatabase();

  final isar = database.isar!;

  while (true) {
    await Future.delayed(const Duration(seconds: 10));
    final topics = await isar.topics.filter().doneEqualTo(false).findAll();
    if (topics.isNotEmpty) {
      for (final i in topics) {
        if (i.maxReplyCount <= i.replies.length) {
          i.done = true;
          // await isar.topics.put(i);
        }
      }

      await isar.writeTxn(() async {
        await isar.topics.putAll(topics);
      });

      /// 修改逻辑， 每次只选择其中一个生成
      /// 主要是舍不得 token
      topics.retainWhere((v) => !v.done);

      if (topics.isEmpty) {
        continue;
      }

      final randomTopic = topics[random.nextInt(topics.length)];
      final users =
          await isar.users.filter().not().typeEqualTo(UserType.you).findAll();

      if (users.isEmpty) {
        continue;
      }

      final user = users[random.nextInt(users.length)];

      await isar.writeTxn(() async {
        final reply = await client.chat([
          SystemChatMessage(
              content: "${user.getPrompt()}，请尝试回复以下用户，回复长度在50到100字。"),
          ChatMessage.humanText("用户说: ${randomTopic.content}")
        ]);
        final replyText = reply.outputAsString;
        final replyTopic = TopicReply()..content = replyText;
        replyTopic.user.value = user;
        randomTopic.replies.add(replyTopic);
        user.lastActiveAt = DateTime.now().millisecondsSinceEpoch;

        await isar.users.put(user);
        await isar.topicReplys.put(replyTopic);
        await replyTopic.user.save();
        await randomTopic.replies.save();
        await isar.topics.put(randomTopic);
      });

      data.sendPort.send(randomTopic.id);
    }
  }
}
