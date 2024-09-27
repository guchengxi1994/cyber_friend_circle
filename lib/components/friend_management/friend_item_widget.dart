import 'package:cyber_friend_circle/isar/user.dart';
import 'package:expand/expand.dart';
import 'package:flutter/material.dart';

class FriendItemWidget extends StatelessWidget {
  const FriendItemWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ExpandableTile(
      title: const Text('Tile 1'),
      detailsBuilder: (context) => Container(height: 200),
    );
  }
}
