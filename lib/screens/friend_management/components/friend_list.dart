import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/material.dart';

import 'friend_item_widget.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key, required this.friends});
  final List<User> friends;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= 500) {
      return ListView.builder(
          itemCount: friends.length,
          itemBuilder: (c, i) {
            return FriendItemWidget(user: friends[i]);
          });
    }

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: friends
          .map((v) => FriendItemWidget(
                user: v,
              ))
          .toList(),
    );
  }
}
