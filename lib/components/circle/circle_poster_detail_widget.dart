import 'package:cyber_friend_circle/components/circle/circle_poster_widget.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'circle_poster_reply_widget.dart';

class CirclePosterDetailWidget extends ConsumerStatefulWidget {
  const CirclePosterDetailWidget(
      {super.key,
      required this.top,
      required this.topic,
      required this.user,
      required this.height});
  final double top;
  final Topic topic;
  final User user;
  final double height;

  @override
  ConsumerState<CirclePosterDetailWidget> createState() =>
      _CirclePosterDetailWidgetState();
}

class _CirclePosterDetailWidgetState
    extends ConsumerState<CirclePosterDetailWidget> {
  late double top = widget.top;

  bool isAtTop = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((c) {
      setState(() {
        top = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TopicReply> replies = widget.topic.replies.toList();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          AnimatedPositioned(
            onEnd: () {
              setState(() {
                isAtTop = !isAtTop;
              });
            },
            top: top,
            duration: const Duration(milliseconds: 500),
            // height: widget.height,
            width: MediaQuery.of(context).size.width,
            curve: Curves.easeInOut,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - top,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CirclePoster(topic: widget.topic, user: widget.user),
                    ...replies.map((e) {
                      return CirclePosterReplyWidget(reply: e);
                    }),
                  ],
                ),
              ),
            ),
          ),
          if (isAtTop)
            Positioned(
              top: 30,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            )
        ],
      ),
    );
  }
}
