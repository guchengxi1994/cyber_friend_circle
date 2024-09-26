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
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child: MarkdownBlock(data: reply.content ?? ""),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width - 90,
                child: Row(
                  children: [
                    Text(DateTime.fromMillisecondsSinceEpoch(reply.createAt)
                        .toLocal()
                        .toString()
                        .split(".")[0]),
                    const Spacer(),
                    if (reply.reaction == Reaction.like)
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.thumb_up,
                            color: Colors.green, size: 15),
                      ),
                    if (reply.reaction == Reaction.dislike)
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.thumb_down,
                            color: Colors.red, size: 15),
                      ),
                    if (reply.reaction == Reaction.none)
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.thumb_up_alt_outlined,
                            color: Colors.grey, size: 15),
                      ),
                    if (reply.reaction == Reaction.none)
                      const SizedBox(width: 20),
                    if (reply.reaction == Reaction.none)
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.thumb_down_alt_outlined,
                            color: Colors.grey, size: 15),
                      ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
