import 'dart:ui';

import 'package:cyber_friend_circle/components/circle/circle_poster_widget.dart';
import 'package:cyber_friend_circle/components/circle/custom_scrollview.dart';
import 'package:cyber_friend_circle/screens/circle_posters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/text_input/rich_text_input_field.dart';

class CirclePostersScreen extends ConsumerStatefulWidget {
  const CirclePostersScreen({super.key});

  @override
  ConsumerState<CirclePostersScreen> createState() =>
      _CirclePostersScreenState();
}

class _CirclePostersScreenState extends ConsumerState<CirclePostersScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(circlePostersProvider);

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (state.showBottom) {
                ref.read(circlePostersProvider.notifier).toggleBottom();
              }
            },
            child: CustomScrollview(
                header: Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken), // 为图片应用颜色过滤器
                      child: Image.asset(
                        "assets/bgs/bg1.jpeg",
                        width: MediaQuery.of(context).size.width,
                        // height: 300,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    if (!state.inputExpaned)
                      Positioned(
                        top: 30,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(circlePostersProvider.notifier)
                                .toggleBottom();
                          },
                          child: Icon(
                            !state.showBottom ? Icons.add : Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
                body: Column(
                  children: [
                    CirclePoster(
                      topic: state.topics[0],
                      user: ref.read(circlePostersProvider.notifier).user,
                    )
                  ],
                )),
          ),
          if (state.showBottom)
            Positioned(
              bottom: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
            ),
          if (state.showBottom)
            Positioned(
              bottom: 5,
              child: RichTextInputField(
                onSubmit: (String text) {},
                onExpandChanged: (bool e) {
                  ref.read(circlePostersProvider.notifier).changeInputExpand(e);
                },
              ),
            )
        ],
      ),
    ));
  }
}
