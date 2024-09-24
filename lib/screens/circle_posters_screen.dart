import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/text_input/rich_text_input_field.dart';

class CirclePostersScreen extends StatefulWidget {
  const CirclePostersScreen({super.key});

  @override
  State<CirclePostersScreen> createState() => _CirclePostersScreenState();
}

class _CirclePostersScreenState extends State<CirclePostersScreen> {
  bool showBottom = false;
  bool expanded = false;
  double height = 200;
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 监听滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (height == 200) {
          setState(() {
            height = 400;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (height == 400) {
          setState(() {
            height = 200;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !expanded
          ? AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showBottom = !showBottom;
                      });
                    },
                    child: Icon(!showBottom ? Icons.add : Icons.remove),
                  ),
                )
              ],
            )
          : null,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (showBottom) {
                setState(() {
                  showBottom = !showBottom;
                });
              }
            },
            child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      title: const Text('Floating Nested SliverAppBar'),
                      floating: true,
                      expandedHeight: height,
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ];
                },
                body: Container(
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15))),
                  child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child: Center(child: Text('Item $index')),
                        );
                      }),
                )),
          ),
          if (showBottom)
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
          if (showBottom)
            Positioned(
              bottom: 5,
              child: RichTextInputField(
                onSubmit: (String text) {},
                onExpandChanged: (bool e) {
                  setState(() {
                    expanded = e;
                  });
                },
              ),
            )
        ],
      ),
    );
  }
}
