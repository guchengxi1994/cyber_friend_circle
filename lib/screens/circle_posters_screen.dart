import 'dart:ui';

import 'package:cyber_friend_circle/components/circle/circle_poster_reply_widget.dart';
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

class _CirclePostersScreenState extends ConsumerState<CirclePostersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    // initTestData();

    // 创建一个 AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 4), // 动画持续时间
      vsync: this,
    );

    // 创建一个 Tween，从1.0到1.1（放大10%）
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成时反转
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 动画返回到初始状态时重新开始
          _controller.forward();
        }
      });

    // 开始动画
    _controller.forward();
  }

  /// FOR TEST
  ///
  /// TODO: remove later
  initTestData() {
    Future.microtask(() {
      ref.read(circlePostersProvider.notifier).insertTestData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(circlePostersProvider);

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[300],
            child: GestureDetector(
              onTap: () {
                if (state.showBottom) {
                  ref.read(circlePostersProvider.notifier).toggleBottom();
                }
              },
              child: CustomScrollview(
                  header: ClipRect(
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _animation.value,
                              child: Image.asset(
                                "assets/bgs/bg1.jpeg",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
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
                  ),
                  body: Column(
                    children: [
                      CirclePoster(
                        topic: state.topics[0],
                        user: ref.read(circlePostersProvider.notifier).user,
                      ),
                      ...state.topics[0].replies
                          .map((e) => CirclePosterReplyWidget(reply: e))
                    ],
                  )),
            ),
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
