import 'package:isar/isar.dart';

import 'image.dart';

part 'user.g.dart';

enum UserType { you, friend, blacklist }

@collection
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? name;
  String? avatar;

  @Enumerated(EnumType.name)
  UserType type = UserType.you;

  @Enumerated(EnumType.name)
  ImageType avatarType = ImageType.asset;

  List<String> characters = [];

  int createAt = DateTime.now().millisecondsSinceEpoch;

  int lastActiveAt = DateTime.now().millisecondsSinceEpoch;

  String personalTagline = "一个努力追求卓越的平常人。";

  String getPrompt() {
    if (type == UserType.you) {
      return "";
    }

    String t = type == UserType.friend ? "好友" : "损友";

    if (characters.isEmpty) {
      return "你的名字叫$name,你是用户的$t。";
    }
    String c = "你是一个${characters.join("，")}人";

    return "你的名字叫$name,你是用户的$t，$c。";
  }

  @override
  bool operator ==(Object other) {
    return other is User && other.id == id;
  }

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}
