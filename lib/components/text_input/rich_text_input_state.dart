class RichTextInputState {
  bool highlighted;
  bool expanded;
  String text;

  RichTextInputState({
    this.highlighted = false,
    this.expanded = false,
    this.text = '',
  });

  RichTextInputState copyWith({
    bool? highlighted,
    bool? expanded,
    String? text,
  }) {
    return RichTextInputState(
      highlighted: highlighted ?? this.highlighted,
      expanded: expanded ?? this.expanded,
    );
  }
}
