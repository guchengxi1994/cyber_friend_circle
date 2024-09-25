import 'package:cyber_friend_circle/isar/board.dart';
import 'package:cyber_friend_circle/isar/topic.dart';

class CirclePostersState {
  final bool showBottom;
  final bool bgImageExpanded;
  final bool inputExpaned;

  final List<Topic> topics;
  final Board? board;

  CirclePostersState({
    this.showBottom = false,
    this.bgImageExpanded = false,
    this.inputExpaned = false,
    this.topics = const [],
    this.board,
  });

  CirclePostersState copyWith({
    bool? showBottom,
    bool? bgImageExpanded,
    List<Topic>? topics,
    bool? inputExpaned,
    Board? board,
  }) {
    return CirclePostersState(
      showBottom: showBottom ?? this.showBottom,
      bgImageExpanded: bgImageExpanded ?? this.bgImageExpanded,
      topics: topics ?? this.topics,
      inputExpaned: inputExpaned ?? this.inputExpaned,
      board: board ?? this.board,
    );
  }
}
