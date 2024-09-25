import 'package:cyber_friend_circle/isar/image.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'circle_posters_state.dart';

class CirclePostersNotifier extends AutoDisposeNotifier<CirclePostersState> {
  @override
  CirclePostersState build() {
    /// TODO remove this test data

    return CirclePostersState(topics: [
      Topic()
        ..content = """
## 今天不加班，好开心

为什么不加班呢？

因为加班没有加班费。😀
"""
        ..createAt = DateTime.now().millisecondsSinceEpoch
        ..id = 1
    ]);
  }

  /// TODO remove this test data
  User get user => User()
    ..id = 1
    ..name = "xiaoshuyui"
    ..avatar = "assets/avatars/f1.webp"
    ..type = UserType.you
    ..avatarType = ImageType.asset;

  void toggleBottom() {
    state = state.copyWith(showBottom: !state.showBottom);
  }

  void changeBgExpand() {
    state = state.copyWith(bgImageExpanded: !state.bgImageExpanded);
  }

  void changeInputExpand(bool b) {
    state = state.copyWith(inputExpaned: b);
  }
}

final circlePostersProvider =
    AutoDisposeNotifierProvider<CirclePostersNotifier, CirclePostersState>(
  CirclePostersNotifier.new,
);
