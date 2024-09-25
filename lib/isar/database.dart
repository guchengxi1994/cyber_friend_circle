import 'package:cyber_friend_circle/global/global.dart' show logger;
import 'package:cyber_friend_circle/isar/board.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:isar/isar.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  // ignore: avoid_init_to_null
  late Isar? isar = null;
  static final _instance = IsarDatabase._init();

  factory IsarDatabase() => _instance;

  IsarDatabase._init();

  Future initialDatabase() async {
    if (isar != null && isar!.isOpen) {
      return;
    }
    final dir = await getApplicationSupportDirectory();
    logger.info("database save to ${dir.path}");
    isar = await Isar.open(
      schemas,
      name: "cfc",
      directory: dir.path,
    );
  }

  late List<CollectionSchema<Object>> schemas = [
    UserSchema,
    TopicReplySchema,
    TopicSchema,
    BoardSchema
  ];
}
