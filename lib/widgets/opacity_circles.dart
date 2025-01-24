import 'package:flutter/material.dart';

class OpacityCircles extends StatelessWidget {
  final Widget? child;
  final Size? screenSize;
  const OpacityCircles({
    super.key,
    this.child,
    this.screenSize,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Circles(left: -70, right: -70),
        const Circles(left: 10, right: -70),
        const Circles(left: -70, right: 10),
        if (child != null) Align(alignment: Alignment.center, child: child!)
      ],
    );
  }
}

class Circles extends StatelessWidget {
  final double? right;
  final double? left;
  const Circles({super.key, @required this.right, @required this.left});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      top: left,
      child: Opacity(
        opacity: 0.3,
        child: Container(
          height: 175,
          width: 175,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }
}
