import 'package:flutter/material.dart';

import '../components/text_input/rich_text_input_field.dart';

class CirclePostersScreen extends StatefulWidget {
  const CirclePostersScreen({super.key});

  @override
  State<CirclePostersScreen> createState() => _CirclePostersScreenState();
}

class _CirclePostersScreenState extends State<CirclePostersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
              bottom: 5,
              child: RichTextInputField(
                onSubmit: (String text) {},
                onExpandChanged: (bool expanded) {},
              ))
        ],
      ),
    );
  }
}
