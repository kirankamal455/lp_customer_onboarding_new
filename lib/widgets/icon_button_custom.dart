import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? icon;

  const IconButtonCustom(
      {super.key,
      @required this.backgroundColor,
      @required this.iconColor,
      @required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      // color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: IconButton(
          icon: Icon(
            icon,
            color: iconColor,
            size: 25,
          ),
          onPressed: () {}),
    );
  }
}
