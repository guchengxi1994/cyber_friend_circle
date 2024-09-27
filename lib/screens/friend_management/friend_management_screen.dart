import 'package:cyber_friend_circle/components/friend_management/friend_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    ));
  }
}
