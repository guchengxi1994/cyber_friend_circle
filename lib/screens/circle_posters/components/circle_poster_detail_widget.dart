import 'package:cyber_friend_circle/screens/circle_posters/components/circle_poster_widget.dart';
import 'package:cyber_friend_circle/isar/topic.dart';
import 'package:cyber_friend_circle/isar/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../replies_notifier.dart';
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
    // List<TopicReply> replies = widget.topic.replies.toList();
    final state = ref.watch(repliesProvider(widget.topic.id));

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: MediaQuery.of(context).size.height,
          ),
          AnimatedPositioned(
            onEnd: () {
              if (!isAtTop && top == 0) {
                setState(() {
                  isAtTop = true;
                });
              }
            },
            top: top,
            duration: const Duration(milliseconds: 500),
            // height: widget.height,
            width: MediaQuery.of(context).size.width - 60,
            curve: Curves.easeInOut,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - top,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CirclePoster(
                      topic: widget.topic,
                      user: widget.user,
                      onTap: () {
                        if (isAtTop) {
                          setState(() {
                            top = widget.top;
                            isAtTop = !isAtTop;
                          });

                          Future.delayed(
                                  const Duration(milliseconds: 500), () {})
                              .then((_) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          });
                        }
                      },
                    ),
                    if (isAtTop)
                      Builder(builder: (c) {
                        return state.when(data: (v) {
                          return Column(
                              children: v.map((e) {
                            return CirclePosterReplyWidget(
                              reply: e,
                              topicId: widget.topic.id,
                            );
                          }).toList());
                        }, error: (_, err) {
                          return Container();
                        }, loading: () {
                          return const SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        });
                      }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
