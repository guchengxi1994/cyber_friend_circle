import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_quill/markdown_quill.dart';

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
              /// TODO show some toast
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
                  width: MediaQuery.of(context).size.width - /* padding */ 40,
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
                          child: GestureDetector(
                              onLongPress: () {
                                /// [避免触发父级的`onLongPress`事件]
                              },
                              child: Center(
                                child: SizedBox(
                                  child: IconButton(
                                    onPressed: () {
                                      final delta =
                                          _controller.document.toDelta();
                                      widget.onSubmit(deltaToMd.convert(delta));
                                    },
                                    icon: Transform.rotate(
                                      angle: -3.14 / 2,
                                      child: const Icon(Icons.send),
                                    ),
                                  ),
                                ),
                              )),
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
