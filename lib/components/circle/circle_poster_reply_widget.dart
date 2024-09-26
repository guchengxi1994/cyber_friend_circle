import 'package:cyber_friend_circle/isar/image.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

import 'avatar.dart';

class CirclePosterReplyWidget extends StatelessWidget {
  const CirclePosterReplyWidget({super.key, required this.reply});
  final TopicReply reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            avatar: reply.user.value?.avatar,
            type: reply.user.value?.avatarType ?? ImageType.none,
            name: reply.user.value?.name ?? "N",
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                child: Text(reply.user.value?.name ?? "N"),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: MarkdownBlock(data: reply.content ?? ""),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ],
      ),
    );
  }
}
