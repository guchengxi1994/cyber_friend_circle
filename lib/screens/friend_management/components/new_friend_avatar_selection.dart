import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;

import '../new_friend_notifier.dart';

typedef OnItemSelect = void Function(String url);

class NewFriendAvatarSelection extends ConsumerStatefulWidget {
  const NewFriendAvatarSelection({super.key, required this.url});
  final String url;

  @override
  ConsumerState<NewFriendAvatarSelection> createState() =>
      _NewFriendAvatarSelectionState();
}

class _NewFriendAvatarSelectionState
    extends ConsumerState<NewFriendAvatarSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 创建一个 AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // 动画持续时间
      vsync: this,
    );

    // 创建一个 Tween，从1.0到1.1（放大10%）
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newFriendProvider);

    return MouseRegion(
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: badges.Badge(
        showBadge: state.url == widget.url,
        badgeContent: Icon(
          Icons.check,
          size: 10,
          color: Colors.green,
        ),
        child: GestureDetector(
          onTap: () {
            ref.read(newFriendProvider.notifier).changeUrl(widget.url);
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Image.asset(
                    widget.url,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
