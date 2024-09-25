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

  int createAt = DateTime.now().millisecondsSinceEpoch;
}
