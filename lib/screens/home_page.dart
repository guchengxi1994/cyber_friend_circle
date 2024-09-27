import 'dart:isolate';
import 'dart:ui';

import 'package:cyber_friend_circle/components/sidebar/sidebar.dart';
import 'package:cyber_friend_circle/components/sidebar/sidebar_notifier.dart';
import 'package:cyber_friend_circle/global/ai_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'circle_posters/circle_posters_notifier.dart';
import 'circle_posters/circle_posters_screen.dart';
import 'friend_management/friend_management_screen.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
              child: PageView(
            controller: ref.read(sidebarProvider.notifier).pageController,
            children: const [
              FriendManagementScreen(),
              CirclePostersScreen(),
            ],
          ))
        ],
      ),
    );
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
}
