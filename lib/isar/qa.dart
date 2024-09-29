import 'package:isar/isar.dart';

part 'qa.g.dart';

@collection
class Qa {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  late String question;
  late String answer;

  late int tokenUsed;
}
