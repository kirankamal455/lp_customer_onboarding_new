import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;
  const Avatar({super.key, this.radius = 48});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: const Icon(Icons.person),
    );
  }
}
