import 'package:cyber_friend_circle/global/global.dart';
import 'package:cyber_friend_circle/screens/friend_management/components/new_friend_avatar_selection.dart';
import 'package:cyber_friend_circle/screens/friend_management/friend_management_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFriemdCreation extends ConsumerStatefulWidget {
  const NewFriemdCreation({super.key});

  @override
  ConsumerState<NewFriemdCreation> createState() => _NewFriemdCreationState();
}

class _NewFriemdCreationState extends ConsumerState<NewFriemdCreation> {
  @override
  Widget build(BuildContext context) {
    final _ = ref.read(friendManagementProvider);

    final obj = AssetsLoader.getAssets("avatar");
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 400,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: obj.items
                  .map((v) => NewFriendAvatarSelection(
                      url: obj.prefix + v, onItemSelect: (s) {}))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
