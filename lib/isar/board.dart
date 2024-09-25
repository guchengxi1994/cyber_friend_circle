import 'package:isar/isar.dart';

import 'image.dart';

part 'board.g.dart';

@collection
class Board {
  Id id = Isar.autoIncrement;
  String? bgImage;

  @Enumerated(EnumType.name)
  ImageType bgType = ImageType.none;

  int createAt = DateTime.now().millisecondsSinceEpoch;
}
