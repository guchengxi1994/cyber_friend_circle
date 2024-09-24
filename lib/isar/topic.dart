import 'package:isar/isar.dart';

import 'user.dart';

part 'topic.g.dart';

@collection
class Topic {
  Id id = Isar.autoIncrement;
  String? content;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  IsarLinks<TopicReply> replies = IsarLinks<TopicReply>();
}

@collection
class TopicReply {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? content;
  IsarLink<User> user = IsarLink<User>();
}
