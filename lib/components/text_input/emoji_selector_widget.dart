import 'package:cyber_friend_circle/global/global.dart';
import 'package:flutter/material.dart';

typedef EmojiSelectedCallback = void Function(String emoji);

class EmojiSelectorWidget extends StatelessWidget {
  const EmojiSelectorWidget({super.key, required this.onEmojiSelected});
  final EmojiSelectedCallback onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1), // 从顶部之外开始动画
              end: const Offset(0, 0), // 最终位置为顶部
            ).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOut,
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: AssetsLoader.getAssets("emoji")
                      .items
                      .map((v) => InkWell(
                            onTap: () {
                              onEmojiSelected(v);
                            },
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Text(v),
                            ),
                          ))
                      .toList()
                    ..add(InkWell(
                      onTap: () {
                        onEmojiSelected("\n");
                      },
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: Transform.rotate(
                          angle: -3.14 / 4,
                          child: const Icon(Icons.call_missed),
                        ),
                      ),
                    )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
