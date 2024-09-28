import 'package:cyber_friend_circle/screens/friend_management/components/friend_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/new_friend_creation.dart';
import 'friend_management_notifier.dart';

class FriendManagementScreen extends ConsumerWidget {
  const FriendManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(friendManagementProvider);

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FriendList(
          friends: state.friends,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
              barrierColor: Colors.transparent,
              barrierDismissible: true,
              barrierLabel: "new friend",
              context: context,
              pageBuilder: (c, _, __) {
                return const Center(
                  child: NewFriemdCreation(),
                );
              });
        },
        tooltip: '添加好友',
        child: const Icon(Icons.add),
      ),
    ));
  }
}
