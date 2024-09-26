import 'package:isar/isar.dart';

import 'user.dart';

part 'topic.g.dart';

enum ReplyType { text, image, animatedEmoji, emoji }

enum Reaction { like, dislike, none }

@collection
class Topic {
  Id id = Isar.autoIncrement;
  String? content;
  int createAt = DateTime.now().millisecondsSinceEpoch;

  int maxReplyCount = 1;
  bool done = false;

  IsarLinks<TopicReply> replies = IsarLinks<TopicReply>();
}

@collection
class TopicReply {
  Id id = Isar.autoIncrement;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  String? content;

  @enumerated
  ReplyType replyType = ReplyType.text;

  @enumerated
  Reaction reaction = Reaction.none;

  IsarLink<User> user = IsarLink<User>();
}
