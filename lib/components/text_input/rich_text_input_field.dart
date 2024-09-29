import 'dart:io';

import 'package:cyber_friend_circle/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_quill/markdown_quill.dart';

import 'emoji_selector_widget.dart';
import 'rich_text_input_notifier.dart';

typedef OnSubmit = void Function(String text);
typedef OnExpandChanged = void Function(bool expanded);

class RichTextInputField extends ConsumerStatefulWidget {
  const RichTextInputField(
      {super.key, required this.onSubmit, required this.onExpandChanged});
  final OnSubmit onSubmit;
  final OnExpandChanged onExpandChanged;

  @override
  ConsumerState<RichTextInputField> createState() => _RichTextInputFieldState();
}

class _RichTextInputFieldState extends ConsumerState<RichTextInputField> {
  final _controller = QuillController.basic();
  final _focusNode = FocusNode();
  final deltaToMd = DeltaToMarkdown();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      ref.read(richTextInputProvider.notifier).toggleHighlight();
    } else {
      ref.read(richTextInputProvider.notifier).toggleUnHighlight();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(richTextInputProvider);

    return Container(
      color: state.expanded ? Colors.white : Colors.transparent,
      // height: state.expanded ? MediaQuery.of(context).size.height - 70 : 75,
      child: GestureDetector(
        onLongPress: () {
          if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
            if (MediaQuery.of(context).size.width > 1000) {
              ref.read(richTextInputProvider.notifier).toggleExpand();
              widget.onExpandChanged(!state.expanded);
            } else {
              ToastUtils.error(context, title: "桌面端展开富文本编辑器请将窗口最大化");
            }
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width - /* padding */ 100,
                  height: state.expanded
                      ? MediaQuery.of(context).size.height - 70
                      : 75,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: state.highlighted ? Colors.blue : Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: state.expanded
                            ? MediaQuery.of(context).size.height - 70
                            : 75,
                        child: QuillEditor.basic(
                          focusNode: _focusNode,
                          controller: _controller,
                          configurations: const QuillEditorConfigurations(
                            padding: EdgeInsets.all(4),
                          ),
                        ),
                      )),
                      SizedBox(
                        height: state.expanded
                            ? MediaQuery.of(context).size.height - 70
                            : 75,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onLongPress: () {
                                    /// [避免触发父级的`onLongPress`事件]
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (c) {
                                                return EmojiSelectorWidget(
                                                  onEmojiSelected: (emoji) {
                                                    final currentPosition =
                                                        _controller.selection
                                                            .baseOffset; // 获取光标位置
                                                    if (currentPosition == -1) {
                                                      return;
                                                    }

                                                    _controller.document.insert(
                                                        currentPosition, emoji);
                                                    // 更新光标位置到插入文本后
                                                    _controller.updateSelection(
                                                      TextSelection.collapsed(
                                                          offset:
                                                              currentPosition +
                                                                  emoji.length),
                                                      ChangeSource.local,
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.emoji_emotions),
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onLongPress: () {
                                    /// [避免触发父级的`onLongPress`事件]
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      child: IconButton(
                                        onPressed: () {
                                          final delta =
                                              _controller.document.toDelta();
                                          widget.onSubmit(
                                              deltaToMd.convert(delta));
                                        },
                                        icon: Transform.rotate(
                                          angle: -3.14 / 2,
                                          child: const Icon(Icons.send),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (state.expanded)
              QuillToolbar.simple(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(
                    showAlignmentButtons: false,
                    showFontSize: false,
                    showFontFamily: false,
                    showCodeBlock: false,
                    showInlineCode: false,
                    showSubscript: false,
                    showSuperscript: false,
                    showSearchButton: false),
              ),
          ],
        ),
      ),
    );
  }
}
