import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomScrollview extends StatefulWidget {
  const CustomScrollview({super.key, required this.body, required this.header});
  final Widget header;
  final Widget body;

  @override
  State<CustomScrollview> createState() => _CustomScrollviewState();
}

class _CustomScrollviewState extends State<CustomScrollview> {
  bool expanded = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      print(controller.position.userScrollDirection);

      if (controller.offset >= 150 &&
          controller.offset < 400 &&
          expanded &&
          controller.position.userScrollDirection == ScrollDirection.reverse) {
        controller.animateTo(400,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceOut);
      }

      if (controller.offset >= 50 &&
          controller.offset < 200 &&
          !expanded &&
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
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: AnimatedContainer(
              height: expanded ? 400 : 200,
              duration: const Duration(milliseconds: 300),
              child: widget.header,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: widget.body,
          )
        ],
      ),
    );
  }
}
