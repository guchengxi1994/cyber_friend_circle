import 'dart:isolate';
import 'dart:ui';

// ignore: unused_import
import 'package:cyber_friend_circle/components/circle/circle_poster_detail_widget.dart';
import 'package:cyber_friend_circle/components/circle/circle_poster_widget.dart';
import 'package:cyber_friend_circle/components/circle/custom_scrollview.dart';
import 'package:cyber_friend_circle/global/ai_client.dart';
import 'package:cyber_friend_circle/screens/circle_posters/circle_posters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../components/text_input/rich_text_input_field.dart';
import '../../global/global.dart';

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

  final AiClient aiClient = AiClient();

  // ignore: unused_field
  late SendPort _sendPort;

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

    start();
  }

  void start() async {
    final receivePort = ReceivePort();
    var rootToken = RootIsolateToken.instance!;
    await Isolate.spawn<IsolateData>(
        startIsolate, IsolateData(receivePort.sendPort, rootToken));

    receivePort.listen((message) {
      if (message is int) {
        ref.read(circlePostersProvider.notifier).refresh();
      }
    });
  }

  /// FOR TEST
  ///
  /// TODO: remove later
  initTestData() {
    Future.microtask(() {
      ref.read(circlePostersProvider.notifier).insertTestData();
    });
  }

  List<GlobalKey> keys = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(circlePostersProvider);

    keys = state.topics
        .mapIndexed((i, e) => GlobalKey(debugLabel: "poster_$i"))
        .toList();

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
                // body: Column(
                //   children: [
                //     CirclePoster(
                //       topic: state.topics[0],
                //       user: ref.read(circlePostersProvider.notifier).user,
                //     ),
                //     ...state.topics[0].replies
                //         .map((e) => CirclePosterReplyWidget(reply: e))
                //   ],
                // )
                body: Column(
                  children: state.topics
                      .mapIndexed((i, e) => CirclePoster(
                          key: keys[i],
                          onTap: () {
                            final v = _getPosition(keys[i]);
                            Navigator.of(context).push(noAnimationRoute(
                              CirclePosterDetailWidget(
                                top: v.$1,
                                height: v.$2,
                                topic: e,
                                user: ref
                                    .read(circlePostersProvider.notifier)
                                    .user,
                              ),
                            ));
                          },
                          topic: e,
                          user: ref.read(circlePostersProvider.notifier).user))
                      .toList(),
                ),
              ),
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
                onSubmit: (String text) {
                  ref.read(circlePostersProvider.notifier).postNewTopic(text);
                },
                onExpandChanged: (bool e) {
                  ref.read(circlePostersProvider.notifier).changeInputExpand(e);
                },
              ),
            )
        ],
      ),
    ));
  }

  (double, double) _getPosition(GlobalKey key) {
    // 获取当前元素的 RenderBox
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    // 获取元素的在屏幕中的位置
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    return (position.dy, size.height);
  }
}
