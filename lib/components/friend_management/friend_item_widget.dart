import 'package:cyber_friend_circle/components/circle/avatar.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:expand/expand.dart';
import 'package:flutter/material.dart';

class FriendItemWidget extends StatelessWidget {
  const FriendItemWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width > 500 ? 500 : width,
      child: ExpandableCard(
        elevationExpanded: 10,
        elevationCollapsed: 10,
        shapeCollapsed:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shapeExpanded:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        marginCollapsed: const EdgeInsets.only(bottom: 10),
        marginExpanded: const EdgeInsets.only(bottom: 10),
        controller: ExpandableController(expandedID: user.name),
        childBuilder: (c, _) => Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(color: Colors.white),
          height: 70,
          child: Row(
            children: [
              Avatar(avatar: user.avatar, type: user.avatarType),
              const SizedBox(
                width: 10,
              ),
              Text(user.name ?? "")
            ],
          ),
        ),
        detailsBuilder: (context) => Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                      "相识于: ${DateTime.fromMillisecondsSinceEpoch(user.createAt).toString().split(" ").first}"),
                  const Spacer(),
                  Text(
                      "最后活跃于: ${DateTime.fromMillisecondsSinceEpoch(user.lastActiveAt).toString().split(" ").first}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
