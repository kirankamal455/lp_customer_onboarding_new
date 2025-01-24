 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorContainer extends ConsumerWidget {
  final Color color;
  final Color color1;
  const ColorContainer({super.key, required this.color, required this.color1});

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        // if (color == const Color(0xFFDF0AFC)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(0);
        // } else if (color == const Color(0xFF4CAF50)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(1);
        // } else if (color == const Color(0xFF25308F)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(2);
        // } else if (color == const Color(0xFF1F1C2C)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(3);
        // } else if (color == const Color(0xFF1A2980)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(4);
        // } else if (color == const Color(0xFFAA076B)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(5);
        // } else if (color == const Color(0xFFAA076A)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(6);
        // } else if (color == const Color(0xFFF21E0A)) {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(7);
        // } else {
        //   ref.read(themecontrollerProvider.notifier).changeTheme(0);
        // }
      },
      // child: Container(
      //   height: 30,
      //   width: 30,
      //   decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      // ),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color1],
            ),
            shape: BoxShape.circle),
      ),
    );
  }
}
