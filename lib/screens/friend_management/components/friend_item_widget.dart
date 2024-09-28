import 'package:cyber_friend_circle/components/avatar.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:cyber_friend_circle/screens/friend_management/friend_management_notifier.dart';
import 'package:expand/expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import 'add_tag_button.dart';

class FriendItemWidget extends ConsumerWidget {
  const FriendItemWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? "",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    // ignore: unnecessary_null_comparison
                    if (user.personalTagline != null &&
                        user.personalTagline.isNotEmpty)
                      Text(
                        user.personalTagline,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.grey),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        detailsBuilder: (context) => Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                      "相识于: ${DateTime.fromMillisecondsSinceEpoch(user.createAt).toString().split(" ").first}"),
                  const Spacer(),
                  Text(
                      "最后活跃于: ${DateTime.fromMillisecondsSinceEpoch(user.lastActiveAt).toString().split(" ").first}"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: unnecessary_null_comparison
              if (user.characters != null)
                Tags(
                  itemCount: user.characters.length + 1,
                  itemBuilder: (int index) {
                    if (index == user.characters.length) {
                      return AddTagButton(
                        onSave: (String s) {
                          ref
                              .read(friendManagementProvider.notifier)
                              .addCharacters(user, s);
                        },
                      );
                    }

                    return ItemTags(
                      removeButton: ItemTagsRemoveButton(onRemoved: () {
                        ref
                            .read(friendManagementProvider.notifier)
                            .removeCharacters(user, user.characters[index]);

                        return true;
                      }),
                      title: user.characters[index],
                      index: index,
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
