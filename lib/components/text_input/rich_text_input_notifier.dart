import 'package:cyber_friend_circle/components/text_input/rich_text_input_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RichTextInputNotifier extends AutoDisposeNotifier<RichTextInputState> {
  @override
  RichTextInputState build() {
    return RichTextInputState();
  }

  void toggleHighlight() {
    state = state.copyWith(highlighted: true);
  }

  void toggleUnHighlight() {
    state = state.copyWith(highlighted: false);
  }

  void toggleExpand() {
    state = state.copyWith(expanded: !state.expanded);
  }
}

final richTextInputProvider =
    AutoDisposeNotifierProvider<RichTextInputNotifier, RichTextInputState>(
        RichTextInputNotifier.new);
