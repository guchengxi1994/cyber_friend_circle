import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFriendNotifier extends AutoDisposeNotifier<String> {
  @override
  String build() {
    return "";
  }

  changeUrl(String url) {
    state = url;
  }
}

final newFriendProvider =
    AutoDisposeNotifierProvider<NewFriendNotifier, String>(() {
  return NewFriendNotifier();
});
