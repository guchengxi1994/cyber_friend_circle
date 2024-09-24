import 'dart:ui';

import 'package:flutter/material.dart';

import '../components/text_input/rich_text_input_field.dart';

class CirclePostersScreen extends StatefulWidget {
  const CirclePostersScreen({super.key});

  @override
  State<CirclePostersScreen> createState() => _CirclePostersScreenState();
}

class _CirclePostersScreenState extends State<CirclePostersScreen> {
  bool showBottom = false;
  bool expanded = false;

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
            child: Container(
              color: Colors.amber,
            ),
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
