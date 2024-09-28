import 'package:cyber_friend_circle/global/global.dart';
import 'package:cyber_friend_circle/screens/friend_management/components/new_friend_avatar_selection.dart';
import 'package:cyber_friend_circle/screens/friend_management/components/styles.dart';
import 'package:cyber_friend_circle/screens/friend_management/friend_management_notifier.dart';
import 'package:cyber_friend_circle/screens/friend_management/new_friend_notifier.dart';
import 'package:expand/expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

class NewFriendCreation extends ConsumerStatefulWidget {
  const NewFriendCreation({super.key});

  @override
  ConsumerState<NewFriendCreation> createState() => _NewFriendCreationState();
}

class _NewFriendCreationState extends ConsumerState<NewFriendCreation> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  late final goodCharacters = AssetsLoader.assets.goodCharacters;
  late final badCharacters = AssetsLoader.assets.badCharacters;

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.read(friendManagementProvider);

    final state = ref.watch(newFriendProvider);

    final obj = AssetsLoader.getAssets("avatar");
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 400,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("输入昵称"),
              TextField(
                decoration: inputDecoration,
                controller: controller,
              ),
              SizedBox(
                height: 20,
              ),
              Text("输入个性签名(可为空)"),
              TextField(
                decoration: inputDecoration,
                controller: controller2,
              ),
              SizedBox(
                height: 20,
              ),
              ExpandableCard(
                elevationExpanded: 0,
                elevationCollapsed: 0,
                shapeCollapsed: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                shapeExpanded: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                marginCollapsed: const EdgeInsets.only(bottom: 10),
                marginExpanded: const EdgeInsets.only(bottom: 10),
                controller: ExpandableController(expandedID: "avatar"),
                detailsBuilder: (_) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: obj.items
                        .map((v) =>
                            NewFriendAvatarSelection(url: obj.prefix + v))
                        .toList(),
                  ),
                ),
                childBuilder: (_, __) => Row(
                  children: [
                    Text(
                      '选择头像',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Transform.rotate(
                      angle: -3.14 / 2,
                      child: Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
              if (state.url != "")
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    state.url,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              ExpandableCard(
                elevationExpanded: 0,
                elevationCollapsed: 0,
                shapeCollapsed: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                shapeExpanded: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                marginCollapsed: const EdgeInsets.only(bottom: 10),
                marginExpanded: const EdgeInsets.only(bottom: 10),
                controller: ExpandableController(expandedID: "character"),
                detailsBuilder: (_) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Tags(
                        itemCount: goodCharacters.length,
                        itemBuilder: (int index) {
                          bool isActive =
                              state.characters.contains(goodCharacters[index]);

                          return ItemTags(
                            onPressed: (i) {
                              ref
                                  .read(newFriendProvider.notifier)
                                  .addOrRemoveCharacter(goodCharacters[index]);
                            },
                            activeColor: Colors.green.withOpacity(0.5),
                            color: Colors.green.withOpacity(0.5),
                            title: goodCharacters[index],
                            index: index,
                            textColor: Colors.black,
                            textActiveColor:
                                isActive ? Colors.black : Colors.white,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Tags(
                        itemCount: badCharacters.length,
                        itemBuilder: (int index) {
                          bool isActive =
                              state.characters.contains(badCharacters[index]);
                          return ItemTags(
                            onPressed: (i) {
                              ref
                                  .read(newFriendProvider.notifier)
                                  .addOrRemoveCharacter(badCharacters[index]);
                            },
                            activeColor: Colors.red.withOpacity(0.5),
                            color: Colors.red.withOpacity(0.5),
                            textColor: Colors.black,
                            textActiveColor:
                                isActive ? Colors.black : Colors.white,
                            title: badCharacters[index],
                            index: index,
                          );
                        },
                      )
                    ],
                  ),
                ),
                childBuilder: (_, __) => Row(
                  children: [
                    Text(
                      '选择个性',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Transform.rotate(
                      angle: -3.14 / 2,
                      child: Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
              if (state.characters.isNotEmpty)
                Text("    是一个${state.characters.join("，")}人"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      ToastUtils.error(context, title: "请输入昵称");
                      return;
                    }

                    if (state.url == "") {
                      ToastUtils.error(context, title: "请选择头像");
                      return;
                    }

                    NewFriendState newFriendState = state.copyWith(
                        name: controller.text,
                        url: state.url,
                        characters: state.characters,
                        signature: controller2.text);

                    Navigator.of(context).pop(newFriendState);
                  },
                  child: Text("确定"))
            ],
          ),
        ),
      ),
    );
  }
}
