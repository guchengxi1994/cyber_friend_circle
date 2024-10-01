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
/**
 * 启动一个隔离进程，用于处理话题回复生成任务。
 * 该函数在一个无限循环中定期检查数据库中的未完成话题，并生成回复。
 * 回复的类型可以是普通的文本、表情符号或者动画表情，根据用户的类型来决定。
 * 该函数使用了隔离进程间的通信来发送回复结果和话题ID。
 *
 * @param data 包含了隔离进程的配置数据和通信令牌。
 */
void startIsolate(IsolateData data) async {
  // 初始化AI客户端和随机数生成器。
  AiClient client = AiClient();
  await client.initOpenAi(DevUtils.env);

  final Random random = Random();

  // 确保背景隔离进程的二进制信使已经初始化。
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.token);

  // 初始化数据库。
  final database = IsarDatabase();

  // 获取传递过来的动画表情和普通表情列表。
  final animatedEmojis = data.animatedEmojis;
  final emojis = data.emojis;

  // 初始化数据库。
  await database.initialDatabase();

  // 获取数据库实例。
  final isar = database.isar!;

  // 无限循环，定期生成话题回复。
  while (true) {
    // 每隔一定时间（回复间隔）检查一次话题。
    await Future.delayed(const Duration(seconds: GlobalSettings.replyDuration));

    // 查询所有未完成的话题。
    final topics = await isar.topics.filter().doneEqualTo(false).findAll();

    // 如果有未完成的话题，则处理这些话题。
    if (topics.isNotEmpty) {
      // 标记所有超过回复限制的话题为已完成。
      for (final i in topics) {
        if (i.maxReplyCount <= i.replies.length) {
          i.done = true;
          // await isar.topics.put(i);
        }
      }

      // 将话题的更新写入数据库。
      await isar.writeTxn(() async {
        await isar.topics.putAll(topics);
      });

      /// 修改逻辑， 每次只选择其中一个生成
      /// 主要是舍不得 token
      topics.retainWhere((v) => !v.done);

      // 如果没有未完成的话题，则跳过本次循环。
      if (topics.isEmpty) {
        continue;
      }

      // 随机选择一个未完成的话题。
      final randomTopic = topics[random.nextInt(topics.length)];

      // 查询所有非“你”的用户。
      final users =
          await isar.users.filter().not().typeEqualTo(UserType.you).findAll();

      // 如果没有用户，则跳过本次循环。
      if (users.isEmpty) {
        continue;
      }

      // 从用户中选择一个合适的用户来回复话题。
      final userReply = randomTopic.getAvailableUser(users);

      // 如果没有合适的用户回复，则发送消息并跳过本次循环。
      if (userReply == null) {
        data.sendPort
            .send("no user available for topic ${randomTopic.content}");
        continue;
      }

      // 获取回复的用户和回复类型。
      final user = userReply.$1;
      final replyType = userReply.$2;

      // 发送用户和回复类型的信息。
      data.sendPort.send("${user.name}  $replyType");

      // 查询 topidId 之前的两条数据
      final itemsBefore = await isar.topics
          .filter()
          .idLessThan(randomTopic.id) // 查询小于 targetId 的记录
          .sortByCreateAtDesc() // 按 id 降序排列
          .limit(2) // 限制返回两条数据
          .findAll();

      // 写入数据库事务。
      await isar.writeTxn(() async {
        final String replyText;
        final replyTopic = TopicReply();

        // 根据回复类型选择回复内容。
        if (replyType == ReplyType.animatedEmoji) {
          replyTopic.replyType = ReplyType.animatedEmoji;
          replyText = animatedEmojis[random.nextInt(animatedEmojis.length)];
        } else if (replyType == ReplyType.emoji) {
          replyTopic.replyType = ReplyType.emoji;
          replyText = emojis[random.nextInt(emojis.length)];
        } else {
          // 使用AI客户端生成回复。
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

          // 将问题和回答保存到数据库。
          await isar.qas.put(qa);
        }

        // 更新话题回复和用户状态。
        replyTopic.content = replyText;
        replyTopic.user.value = user;
        randomTopic.replies.add(replyTopic);
        user.lastActiveAt = DateTime.now().millisecondsSinceEpoch;

        // 保存用户、回复和话题到数据库。
        await isar.users.put(user);
        await isar.topicReplys.put(replyTopic);
        await replyTopic.user.save();
        await randomTopic.replies.save();
        await isar.topics.put(randomTopic);
      });

      // 发送话题ID。
      data.sendPort.send(randomTopic.id);
    }
  }
}

