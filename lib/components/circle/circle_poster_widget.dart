import 'package:cyber_friend_circle/components/circle/avatar.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CirclePoster extends StatelessWidget {
  const CirclePoster({super.key, required this.topic, required this.user});
  final Topic topic;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Avatar(
                  avatar: user.avatar,
                  type: user.avatarType,
                  name: user.name ?? "N",
                ),
                const SizedBox(width: 10),
                Text(user.name ?? "N"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FittedBox(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: MarkdownBlock(data: topic.content ?? ""),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(DateTime.fromMillisecondsSinceEpoch(topic.createAt)
                  .toLocal()
                  .toString()
                  .split(".")[0]),
              const Spacer(),
              Text("回复数: ${topic.replies.length}"),
            ],
          )
        ],
      ),
    );
  }
}
