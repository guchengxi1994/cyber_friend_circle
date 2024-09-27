// 自定义无动画的路由
import 'package:flutter/material.dart';

Route noAnimationRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration.zero, // 禁用动画
    reverseTransitionDuration: Duration.zero, // 禁用返回动画
  );
}
