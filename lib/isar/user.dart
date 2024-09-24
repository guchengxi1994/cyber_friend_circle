import 'package:isar/isar.dart';

part 'user.g.dart';

enum UserType { you, friend, blacklist }

enum AvatarType { asset, url, file }

@collection
class User {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? name;
  String? avatar;

  @Enumerated(EnumType.name)
  UserType type = UserType.you;

  @Enumerated(EnumType.name)
  AvatarType avatarType = AvatarType.asset;

  int createAt = DateTime.now().millisecondsSinceEpoch;
}
