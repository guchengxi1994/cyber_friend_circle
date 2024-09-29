import 'package:cyber_friend_circle/screens/circle_posters/circle_posters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScrollview extends ConsumerStatefulWidget {
  const CustomScrollview({super.key, required this.body, required this.header});
  final Widget header;
  final Widget body;

  @override
  ConsumerState<CustomScrollview> createState() => _CustomScrollviewState();
}

class _CustomScrollviewState extends ConsumerState<CustomScrollview> {
  // bool expanded = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.offset >= 150 &&
          controller.offset < 400 &&
          ref.read(circlePostersProvider.select((v) => v.bgImageExpanded)) &&
          controller.position.userScrollDirection == ScrollDirection.reverse) {
        controller.animateTo(400,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceOut);
      }

      if (controller.offset >= 50 &&
          controller.offset < 200 &&
          !ref.read(circlePostersProvider.select((v) => v.bgImageExpanded)) &&
          controller.position.userScrollDirection == ScrollDirection.reverse) {
        controller.animateTo(200,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceOut);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height =
        ref.watch(circlePostersProvider.select((v) => v.bgImageExpanded))
            ? 400
            : 200;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      controller: controller,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (ref.read(circlePostersProvider).showBottom) {
                ref.read(circlePostersProvider.notifier).toggleBottom();
              }
              ref.read(circlePostersProvider.notifier).changeBgExpand();
            },
            child: AnimatedContainer(
              height: height,
              duration: const Duration(milliseconds: 300),
              child: widget.header,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: widget.body,
          )
        ],
      ),
    );
  }
}
