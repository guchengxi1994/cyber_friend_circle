import 'package:cyber_friend_circle/components/avatar.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:cyber_friend_circle/screens/circle_posters/circle_posters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CirclePoster extends ConsumerWidget {
  const CirclePoster(
      {super.key, required this.topic, required this.user, this.onTap});
  final Topic topic;
  final User user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (ref.read(circlePostersProvider).showBottom) {
          ref.read(circlePostersProvider.notifier).toggleBottom();
        }

        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: MarkdownBlock(
                data: topic.content ?? "",
                selectable: false,
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
      ),
    );
  }
}
