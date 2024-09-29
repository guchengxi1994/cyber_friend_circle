import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:cyber_friend_circle/isar/database.dart';
import 'package:cyber_friend_circle/isar/qa.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:langchain_lib/langchain_lib.dart';

import 'dev_utils.dart';
import 'global.dart';

class IsolateData {
  final SendPort sendPort;
  final RootIsolateToken token;
  final List<String> emojis;
  final List<String> animatedEmojis;

  IsolateData(this.sendPort, this.token,
      {required this.animatedEmojis, required this.emojis});
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

  final animatedEmojis = data.animatedEmojis;
  final emojis = data.emojis;

  await database.initialDatabase();

  final isar = database.isar!;

  while (true) {
    await Future.delayed(const Duration(seconds: GlobalSettings.replyDuration));
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

      /// TODO;FIXME 限制一下用户回答次数或者回答的内容，让回答生成的更加多样化
      final user = users[random.nextInt(users.length)];

      // Step 2: 查询 targetId 之前的两条数据
      final itemsBefore = await isar.topics
          .filter()
          .idLessThan(randomTopic.id) // 查询小于 targetId 的记录
          .sortByCreateAtDesc() // 按 id 降序排列
          .limit(2) // 限制返回两条数据
          .findAll();

      await isar.writeTxn(() async {
        double s = random.nextDouble();
        final String replyText;
        final replyTopic = TopicReply();

        if (s < GlobalSettings.animatedEmojiProportion) {
          replyTopic.replyType = ReplyType.emoji;
          replyText = animatedEmojis[random.nextInt(animatedEmojis.length)];
        } else if (s >= GlobalSettings.animatedEmojiProportion &&
            s <
                GlobalSettings.emojiProportion +
                    GlobalSettings.animatedEmojiProportion) {
          replyText = emojis[random.nextInt(emojis.length)];
        } else {
          final reply = await client.chat([
            SystemChatMessage(
                content: "${user.getPrompt()}，请尝试回复以下用户，回复长度在50到100字。"),
            ChatMessage.humanText("用户说: ${randomTopic.content}"),
            if (itemsBefore.isNotEmpty)
              ChatMessage.humanText(
                  "注意： 用户之前已经说了以下内容：${itemsBefore.map((v) => v.content).toList().join(",")}，请判断之前说的内容和这次是否有关，如果有关请结合之前的内容回答。"),
            ChatMessage.humanText("回复:")
          ]);
          replyText = reply.outputAsString;
          Qa qa = Qa();
          qa.answer = replyText;
          qa.question = """
          "${user.getPrompt()}，请尝试回复以下用户，回复长度在50到100字。"
          "用户说: ${randomTopic.content}"
          ${itemsBefore.isNotEmpty ? "注意： 用户之前已经说了以下内容：${itemsBefore.map((v) => v.content).toList().join(",")}，请判断之前说的内容和这次是否有关，如果有关请结合之前的内容回答。" : ""}
          "回复:"
          """;
          qa.tokenUsed = reply.usage.totalTokens ?? 0;

          await isar.qas.put(qa);
        }

        replyTopic.content = replyText;
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
